from json import JSONDecodeError
from fastapi import FastAPI, HTTPException, Request, Depends
import auth


app = FastAPI()

    
@app.post('/DevOps',dependencies=[Depends(auth.get_api_key)])
async def main(request: Request):
    content_type = request.headers.get('Content-Type')
    
    if content_type is None:
        raise HTTPException(status_code = 422, detail=  "Error")
    elif content_type == 'application/json':
        try:
            json = await request.json()
            return { "message": "Hello  " + json['to'] + " your message will be send"}
        except JSONDecodeError:
            raise HTTPException("Error")
    else:
        raise HTTPException("Error")