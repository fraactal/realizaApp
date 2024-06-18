from flask import Flask
import requests
import json
import os
import logging


app = Flask(__name__)
logging.basicConfig(level=logging.DEBUG)

@app.route("/")
def home():
    try:
        # al ser un docker compose, la url lleba el nombre del servicio realiza-service
        url = f"http://realiza-service:{3000}/obtenerRegistros"
        res = requests.get(url).json()
        return json.dumps(res)
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consultar datos en el servicio de API"}

@app.route("/admin/borrarRegistros")
def borrarRegistros():
    try:
        # al ser un docker compose, la url lleba el nombre del servicio realiza-service
        url = f"http://realiza-service:{3000}/borrarRegistros"
        res = requests.get(url).json()
        return json.dumps(res)
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en borrar datos en el servicio de API"}

@app.route("/admin/crearRegistros")
def crearRegistros():
    try:
        # al ser un docker compose, la url lleba el nombre del servicio realiza-service
        url = f"http://realiza-service:{3000}/crearRegistros"
        res = requests.get(url).json()
        return json.dumps(res)
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en borrar datos en el servicio de API"}


############## RUN SERVER ####################
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=81, debug=True)