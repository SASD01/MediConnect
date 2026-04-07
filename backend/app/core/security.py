import os
import jwt
import httpx
from jwt import PyJWKClient
from fastapi import HTTPException, status
from dotenv import load_dotenv

load_dotenv()

supabase_url = os.getenv('SUPABASE_URL_MEDICONNECT')
JWKS_URL = f"{supabase_url}/auth/v1/.well-known/jwks.json"

jwks_client = PyJWKClient(JWKS_URL)

def verify_token(token: str) -> dict:
    try:
        signing_key = jwks_client.get_signing_key_from_jwt(token)

        payload = jwt.decode(
            token,
            signing_key.key,
            algorithms=["ES256"], 
            options={"verify_aud": False}
        )
        return payload

    except jwt.ExpiredSignatureError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token expirado"
        )
    except jwt.InvalidTokenError as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token inválido"
        )