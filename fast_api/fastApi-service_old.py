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
        url = f"http://realiza-service:{3000}/obtenerCategorias"
        res = requests.get(url).json()
        return json.dumps(res, indent=4)
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consultar datos en el servicio de API"}

@app.route("/SubCategorias")
def SubCategorias():
    try:
        # al ser un docker compose, la url lleba el nombre del servicio realiza-service
        url = f"http://realiza-service:{3000}/SubCategorias"
        res = requests.get(url).json()
        return json.dumps(res, indent=4)
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consultar datos en el servicio de API"}

@app.route("/Alcances")
def Alcances():
    try:
        # al ser un docker compose, la url lleba el nombre del servicio realiza-service
        url = f"http://realiza-service:{3000}/Alcances"
        res = requests.get(url).json()
        return json.dumps(res, indent=4)
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consultar datos en el servicio de API"}

###################################
@app.route("/Proyectos")
def Proyectos():
    try:
        # al ser un docker compose, la url lleba el nombre del servicio realiza-service
        url = f"http://realiza-service:{3000}/Proyectos"
        res = requests.get(url).json()
        return json.dumps(res, indent=4)
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consultar datos en el servicio de API"}

@app.route("/Campus")
def Campus():
    try:
        # al ser un docker compose, la url lleba el nombre del servicio realiza-service
        url = f"http://realiza-service:{3000}/Campus"
        res = requests.get(url).json()
        return json.dumps(res, indent=4)
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consultar datos en el servicio de API"}

@app.route("/Usuarios")
def Usuarios():
    try:
        # al ser un docker compose, la url lleba el nombre del servicio realiza-service
        url = f"http://realiza-service:{3000}/Usuarios"
        res = requests.get(url).json()
        return json.dumps(res, indent=4)
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consultar datos en el servicio de API"}

###################################

@app.route("/UnidadFuente")
def UnidadFuente():
    try:
        # al ser un docker compose, la url lleba el nombre del servicio realiza-service
        url = f"http://realiza-service:{3000}/UnidadFuente"
        res = requests.get(url).json()
        return json.dumps(res, indent=4)
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consultar datos en el servicio de API"}
    

@app.route("/UnidadFactorEmision")
def UnidadFactorEmision():
    try:
        # al ser un docker compose, la url lleba el nombre del servicio realiza-service
        url = f"http://realiza-service:{3000}/UnidadFactorEmision"
        res = requests.get(url).json()
        return json.dumps(res, indent=4)
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consultar datos en el servicio de API"}
    

@app.route("/TiposGasGEI")
def TiposGasGEI():
    try:
        # al ser un docker compose, la url lleba el nombre del servicio realiza-service
        url = f"http://realiza-service:{3000}/TiposGasGEI"
        res = requests.get(url).json()
        return json.dumps(res, indent=4)
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consultar datos en el servicio de API"}


@app.route("/FactoresDeEmision")
def FactoresDeEmision():
    try:
        # al ser un docker compose, la url lleba el nombre del servicio realiza-service
        url = f"http://realiza-service:{3000}/FactoresDeEmision"
        res = requests.get(url).json()
        return json.dumps(res, indent=4)
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consultar datos en el servicio de API"}

@app.route("/Fuentes")
def Fuentes():
    try:
        # al ser un docker compose, la url lleba el nombre del servicio realiza-service
        url = f"http://realiza-service:{3000}/Fuentes"
        res = requests.get(url).json()
        return json.dumps(res, indent=4)
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consultar datos en el servicio de API"}

@app.route("/Consumos")
def Consumos():
    try:
        # al ser un docker compose, la url lleba el nombre del servicio realiza-service
        url = f"http://realiza-service:{3000}/Consumos"
        res = requests.get(url).json()
        return json.dumps(res, indent=4)
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consultar datos en el servicio de API"}


#@app.route("/admin/borrarRegistros")
#def borrarRegistros():
#    try:
#        # al ser un docker compose, la url lleba el nombre del servicio realiza-service
#        url = f"http://realiza-service:{3000}/borrarRegistros"
#        res = requests.get(url).json()
#        return json.dumps(res)
#    except Exception as e:
#        logging.debug(e)
#        return {"message":"Error en borrar datos en el servicio de API"}

#@app.route("/admin/crearRegistros")
#def crearRegistros():
#    try:
#        # al ser un docker compose, la url lleba el nombre del servicio realiza-service
#        url = f"http://realiza-service:{3000}/crearRegistros"
#        res = requests.get(url).json()
#        return json.dumps(res)
#    except Exception as e:
#        logging.debug(e)
#        return {"message":"Error en borrar datos en el servicio de API"}


############## RUN SERVER ####################
#if __name__ == '__main__':
#    app.run(host='0.0.0.0', port=81, debug=True)