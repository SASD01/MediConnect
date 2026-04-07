import os
import sys

import site
# Workaround crucial: Removemos el CWD brevemente para evitar que la carpeta 'supabase' choque con el paquete
_cwd = os.getcwd()
_empty = ""
if _cwd in sys.path: sys.path.remove(_cwd)
if _empty in sys.path: sys.path.remove(_empty)

from dotenv import load_dotenv
from supabase import create_client, Client

# Restauramos el path
sys.path.insert(0, _cwd)
load_dotenv()

supabase_url = os.getenv('SUPABASE_URL_MEDICONNECT')
supabase_anon_key = os.getenv('SUPABASE_ANON_KEY_MEDICONNECT')
supabase_bucket = os.getenv('SUPABASE_BUCKET_MEDICONNECT')
supabase_jwt_secret = os.getenv('SUPABASE_JWT_SECRET')
supabase_service_role_key = os.getenv('SUPABASE_SERVICE_ROLE_KEY_MEDICONNECT')

if not all([supabase_url, supabase_anon_key, supabase_jwt_secret, supabase_service_role_key]):
    raise EnvironmentError(f"Environment variables must be set")


supabase: Client = create_client(supabase_url, supabase_anon_key)
supabase_admin: Client = create_client(supabase_url, supabase_service_role_key)

def get_supabase() -> Client:
    return supabase

def get_supabase_admin() -> Client:
    return supabase_admin