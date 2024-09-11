from fastapi import APIRouter, Response, status, Request

from models.subcategorias import SubCategorias

import logging
import json
import requests


router = APIRouter()

@router.get('/SubCategorias')
def get_subCategorias():
    try:
        # al ser un docker compose, la url lleva el nombre del servicio realiza-service
        url = f"http://realiza-service:{3000}/SubCategorias"
        res = requests.get(url).json()
        json_str = json.dumps(res, indent=4, default=str)

        return Response(content=json_str, media_type='application/json', status_code=status.HTTP_200_OK)
    except Exception as e:
        logging.debug(e)
        # Fortalecer respuestas con errores
        return {"message":"Error en consultar datos en el servicio de API"}

'''
@app.route("/SubCategorias")
def SubCategorias():
    try:
        # al ser un docker compose, la url lleva el nombre del servicio realiza-service
        url = f"http://realiza-service:{3000}/SubCategorias"
        res = requests.get(url).json()
        return json.dumps(res, indent=4)
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consultar datos en el servicio de API"}
'''