"""Logica de autenticacion: registro, login y respuestas normalizadas."""

from typing import Any

from fastapi import HTTPException, status

from app.core.database import get_supabase, get_supabase_admin
from app.modules.auth.schemas import (
    AdminRegisterRequest,
    LoginRequest,
    LoginResponse,
    RegisterRequest,
    RegisterResponse,
    GoogleLoginRequest,
)


def _extract_user_metadata(payload: RegisterRequest | AdminRegisterRequest) -> dict[str, Any]:
    metadata: dict[str, Any] = {
        "first_name": payload.first_name,
        "last_name": payload.last_name,
        "phone": payload.phone,
        "role": payload.role,
    }
    if payload.role == "doctor":
        metadata["license_number"] = payload.license_number
    else:
        metadata["document_number"] = payload.document_number
    return metadata


def register_user(payload: RegisterRequest) -> RegisterResponse:
    supabase = get_supabase()
    try:
        response = supabase.auth.sign_up(
            {
                "email": payload.email,
                "password": payload.password,
                "options": {"data": _extract_user_metadata(payload)},
            }
        )
    except Exception as e:
        # Pydantic or Supabase error (e.g. AuthWeakPasswordError)
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(e),
        )

    user = response.user
    if not user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="No se pudo crear el usuario",
        )

    return RegisterResponse(
        id=user.id,
        email=user.email or payload.email,
        role=payload.role,
        message="Usuario registrado. Revisa tu correo para confirmar la cuenta.",
    )


def register_user_by_admin(payload: AdminRegisterRequest) -> RegisterResponse:
    supabase_admin = get_supabase_admin()
    response = supabase_admin.auth.admin.create_user(
        {
            "email": payload.email,
            "password": payload.password,
            "email_confirm": True,
            "user_metadata": _extract_user_metadata(payload),
        }
    )

    user = response.user
    if not user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="No se pudo crear el usuario desde admin",
        )

    return RegisterResponse(
        id=user.id,
        email=user.email or payload.email,
        role=payload.role,
        message="Usuario creado por administrador.",
    )


def login_user(payload: LoginRequest) -> LoginResponse:
    supabase = get_supabase()
    try:
        response = supabase.auth.sign_in_with_password(
            {"email": payload.email, "password": payload.password}
        )
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=str(e),
        )

    session = response.session
    user = response.user

    if not session or not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Credenciales inválidas",
        )

    role = (user.user_metadata or {}).get("role", "patient")
    return LoginResponse(
        access_token=session.access_token,
        user_id=user.id,
        role=role,
    )


def login_with_google(payload: GoogleLoginRequest) -> LoginResponse:
    supabase = get_supabase()
    try:
        response = supabase.auth.sign_in_with_id_token(
            {"provider": "google", "token": payload.id_token}
        )
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=f"Error en Google Login: {e}",
        )

    session = response.session
    user = response.user

    if not session or not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Credenciales de Google inválidas",
        )

    # El rol por defecto si no lo tienen o si se crearon desde Google, es 'patient'
    role = (user.user_metadata or {}).get("role", "patient")
    return LoginResponse(
        access_token=session.access_token,
        user_id=user.id,
        role=role,
    )
