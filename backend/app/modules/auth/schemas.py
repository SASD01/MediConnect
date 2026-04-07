from typing import Literal

from pydantic import BaseModel, EmailStr, Field, field_validator, model_validator


def _blank_to_none(v: object) -> object:
    if v is None:
        return None
    if isinstance(v, str):
        s = v.strip()
        return s if s else None
    return v


class RegisterRequest(BaseModel):
    email: EmailStr
    password: str
    first_name: str
    last_name: str
    phone: str
    role: Literal["patient", "doctor"]
    license_number: str | None = Field(
        default=None,
        description="Obligatorio si role=doctor. Omitir o dejar vacío para paciente.",
    )
    document_number: str | None = Field(
        default=None,
        description="Obligatorio si role=patient. Omitir o dejar vacío para doctor.",
    )

    @field_validator("license_number", "document_number", mode="before")
    @classmethod
    def normalize_optional_ids(cls, v: object) -> str | None:
        return _blank_to_none(v)

    @model_validator(mode="after")
    def validate_role_fields(self) -> "RegisterRequest":
        if self.role == "doctor":
            if self.document_number is not None:
                raise ValueError("document_number solo se permite para role='patient'")
        else:
            if self.license_number is not None:
                raise ValueError("license_number solo se permite para role='doctor'")
        return self


class AdminRegisterRequest(BaseModel):
    """Solo pacientes y médicos; los administradores los crea MediConnect (fuera de esta API)."""

    email: EmailStr
    password: str
    first_name: str
    last_name: str
    phone: str
    role: Literal["patient", "doctor"]
    license_number: str | None = Field(
        default=None,
        description="Opcional al inicio si role=doctor.",
    )
    document_number: str | None = Field(
        default=None,
        description="Opcional al inicio si role=patient.",
    )

    @field_validator("license_number", "document_number", mode="before")
    @classmethod
    def normalize_optional_ids(cls, v: object) -> str | None:
        return _blank_to_none(v)

    @model_validator(mode="after")
    def validate_role_fields(self) -> "AdminRegisterRequest":
        if self.role == "doctor":
            if self.document_number is not None:
                raise ValueError("document_number solo se permite para role='patient'")
        else:
            if self.license_number is not None:
                raise ValueError("license_number solo se permite para role='doctor'")
        return self

class RegisterResponse(BaseModel):
    id: str
    email: str
    role: str
    message: str

class LoginRequest(BaseModel):
    email: EmailStr
    password: str

class LoginResponse(BaseModel):
    access_token: str
    token_type: str = "bearer"
    user_id: str
    role: str

class GoogleLoginRequest(BaseModel):
    id_token: str
