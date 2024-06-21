from flask import Flask, render_template, request, redirect
import requests
import logging
import json

app = Flask(__name__)
logging.basicConfig(level=logging.DEBUG)


@app.route("/")
def Categorias():
    try:
        # en la raiz, obtiene los datos del servicio faker
        url = f"http://api-service:{81}/"
        res = requests.get(url).json()
        return render_template("categorias.html", categorias = res)

    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consulta de datos web hacia el Api"}


@app.route("/SubCategorias")
def Subcategorias():
    try:
        # en la raiz, obtiene los datos del servicio faker
        url = f"http://api-service:{81}/SubCategorias"
        res = requests.get(url).json()
        return render_template("subcategorias.html", subcategorias = res)

    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consulta de datos web hacia el Api"}

@app.route("/Alcances")
def Alcances():
    try:
        # en la raiz, obtiene los datos del servicio faker
        url = f"http://api-service:{81}/Alcances"
        res = requests.get(url).json()
        return render_template("alcances.html", alcances = res)

    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consulta de datos web hacia el Api"}


@app.route("/admin")
def admin():
    return render_template("admin.html", context = {})


'''
@app.route("/admin/borrarRegistros")
def borrarRegistros():
    try:
        url = f"http://api-service:{81}/admin/borrarRegistros"
        requests.get(url).json()
        return redirect("/admin")
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en borrado de registros"}

@app.route("/admin/crearRegistros")
def crearRegistros():
    try:
        url = f"http://api-service:{81}/admin/crearRegistros"
        requests.get(url).json()
        return redirect("/admin")
    except Exception as e:
        logging.debug(e)
        return {"message":"Error en crear registros"}
'''

############## RUN SERVER ####################
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=82, debug=True)