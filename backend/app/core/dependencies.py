"""Dependencias compartidas: get_current_user y require_role."""
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from app.core.security import verify_token
from app.core.database import get_supabase

bearer_scheme = HTTPBearer() # Para autenticación por token

def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(bearer_scheme)) -> dict:
    # Verifica si el token es válido y obtiene el payload
    token = credentials.credentials
    payload = verify_token(token)


    user_id = payload.get("sub") 
    if not user_id:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token sin usuario válido"
        )

    user_metadata = payload.get("user_metadata", {})
    return {
        "id": user_id,
        "email": payload.get("email"),
        "role": user_metadata.get("role")
    }


def require_role(*roles: str):
    def checker(current_user: dict = Depends(get_current_user)) -> dict:
        if current_user["role"] not in roles:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail=f"Acceso restringido. Se requiere rol: {', '.join(roles)}"
            )
        return current_user
    return checker
