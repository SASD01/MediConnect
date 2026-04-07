"""Endpoints de autenticacion."""

from fastapi import APIRouter, Depends

from app.core.dependencies import get_current_user, require_role
from app.modules.auth.schemas import (
    AdminRegisterRequest,
    LoginRequest,
    LoginResponse,
    RegisterRequest,
    RegisterResponse,
    GoogleLoginRequest,
)
from app.modules.auth.service import login_user, register_user, register_user_by_admin, login_with_google
router = APIRouter(prefix="/auth", tags=["auth"])


@router.post("/register", response_model=RegisterResponse)
def register(payload: RegisterRequest) -> RegisterResponse:
    """Registro público para `patient` y `doctor`."""
    return register_user(payload)


@router.post("/register/admin", response_model=RegisterResponse)
def register_admin(
    payload: AdminRegisterRequest,
    _: dict = Depends(require_role("admin")),
) -> RegisterResponse:
    """Crear pacientes o médicos. Los administradores solo vía MediConnect (no por esta API)."""
    return register_user_by_admin(payload)


@router.post("/login", response_model=LoginResponse)
def login(payload: LoginRequest) -> LoginResponse:
    """Login por email/password y entrega de JWT."""
    return login_user(payload)


@router.post("/login/google", response_model=LoginResponse)
def login_google(payload: GoogleLoginRequest) -> LoginResponse:
    """Login con un idToken de Google y entrega de JWT."""
    return login_with_google(payload)


@router.get("/verify")
def verify(_: dict = Depends(get_current_user)) -> dict:
    """Valida que el token enviado sea correcto."""
    return {"valid": True}


@router.get("/me")
def me(current_user: dict = Depends(get_current_user)) -> dict:
    """Devuelve el perfil mínimo extraído del JWT."""
    return current_user

