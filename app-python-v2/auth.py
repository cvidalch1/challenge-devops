from fastapi import  HTTPException, Security
from fastapi.security.api_key import APIKeyHeader
from starlette.status import HTTP_403_FORBIDDEN


api_keys = "2f5ae96c-b558-4c7b-a590-a501ae1c3f6c"


api_key_header = APIKeyHeader(name="X-Parse-REST-API-Key", auto_error=False)

async def get_api_key(api_key_header: str = Security(api_key_header)):
    if api_key_header == api_keys:
        return api_key_header   
    else:
        raise HTTPException(
            status_code=HTTP_403_FORBIDDEN, detail="Your API KEY is invalid"
        )
    
