from fastapi import APIRouter, Response, status
from models.producto import Product
from models.consumo import Consumo

import logging
import json
import requests

datos_dumy = [{'id_consumo': 'HDC0109', 'fuente': 'Traslado diario de personal - Vehículo particular - gasolina', 'cantidad_fuente': 15754373.0, 'fecha': 1724889600000, 'link_respaldo': 'Resultados Encuesta de movilidad 2022.xlsx', 'comentarios': '', 'huellachile': True, 'campus': 'TALCA'}, 
           {'id_consumo': 'HDC0020', 'fuente': 'Sistema Eléctrico Nacional - Sistema Eléctrico Nacional', 'cantidad_fuente': 5784.31, 'fecha': 1724889600000, 'link_respaldo': 'consumos energ¡a, agua y residuos reciclaje.docx', 'comentarios': '', 'huellachile': True, 'campus': 'TALCA'}, 
           {'id_consumo': 'HDC0039', 'fuente': 'Viajes de negocios - Aéreo - Avión trayecto internacional (promedio)', 'cantidad_fuente': 4009698.27, 'fecha': 1724889600000, 'link_respaldo': 'cometidos internacionales.xlsx', 'comentarios': '', 'huellachile': True, 'campus': 'TALCA'}, 
           {'id_consumo': 'HDC0095', 'fuente': 'Traslado diario de personal - Vehículo particular - diesel', 'cantidad_fuente': 3271664.0, 'fecha': 1724889600000, 'link_respaldo': 'Resultados Encuesta de movilidad 2022.xlsx', 'comentarios': '', 'huellachile': True, 'campus': 'TALCA'}, 
           {'id_consumo': 'HDC0096', 'fuente': 'Traslado diario de personal - Bus interurbano (aprox. 45 pers.)', 'cantidad_fuente': 23258608.0, 'fecha': 1724889600000, 'link_respaldo': 'Resultados Encuesta de movilidad 2022.xlsx', 'comentarios': '', 'huellachile': True, 'campus': 'TALCA'},]

router = APIRouter()

@router.get('/consumos')
def get_consumo():
    try:
        # al ser un docker compose, la url lleva el nombre del servicio realiza-service
        url = f"http://realiza-service:{3000}/Consumos"
        res = requests.get(url).json()
        logging.debug("RES/n")
        logging.debug(res)
        json_str = json.dumps(res, indent=4, default=str)
        logging.debug("json_str/n")
        logging.debug(json_str)
        for field_dict in Consumo.model_validate()['fields']:
            #Consumo.model_validate(field_dict)
            logging.debug("Dentro del Json")
            logging.debug(Consumo.model_validate_json(field_dict)) 

        return Response(content=json_str, media_type='application/json', status_code=status.HTTP_200_OK)
    except Exception as e:
        logging.debug(e)
        # Fortalecer respuestas con errores
        return {"message":"Error en consultar datos en el servicio de API"}

#DateTimePattern['%a, %d %b %Y %H:%M:%S %Z']

#@router.get('/consumosDumy')
#def get_consumo_dumy():
#    try:
#        # al ser un docker compose, la url lleva el nombre del servicio realiza-service
#        for field_dict in datos_dumy['fields']:
#            #Consumo.model_validate()['fields']:
#            #Consumo.model_validate(field_dict)
#            logging.debug("Dentro del Json")
#            logging.debug(Consumo.model_validate_json(field_dict)) 
#
#        #return Response(content=json_str, media_type='application/json', status_code=status.HTTP_200_OK)
#    except Exception as e:
#        logging.debug(e)
#        return {"message":"Error en recorrer la shity"}
