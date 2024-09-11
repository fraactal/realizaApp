from flask import Flask, render_template, request, redirect
import requests
import logging
import json

app = Flask(__name__)
logging.basicConfig(level=logging.DEBUG)


@app.route("/")
def Home():
    try:
        return render_template("admin.html")

    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consulta Home hacia el Api"}

@app.route("/Categorias")
def Categorias():
    try:
        # en la raiz, obtiene los datos del servicio faker
        url = f"http://api-service:{81}/Categorias"
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


###############################

@app.route("/Proyectos")
def Proyectos():
    try:
        # en la raiz, obtiene los datos del servicio faker
        url = f"http://api-service:{81}/Proyectos"
        res = requests.get(url).json()
        return render_template("proyectos.html", proyectos = res)

    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consulta de datos web hacia el Api"}


@app.route("/Campus")
def Campus():
    try:
        # en la raiz, obtiene los datos del servicio faker
        url = f"http://api-service:{81}/Campus"
        res = requests.get(url).json()
        return render_template("campus.html", campuss = res)

    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consulta de datos web hacia el Api"}


@app.route("/Usuarios")
def Usuarios():
    try:
        # en la raiz, obtiene los datos del servicio faker
        url = f"http://api-service:{81}/Usuarios"
        res = requests.get(url).json()
        return render_template("usuarios.html", usuarios = res)

    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consulta de datos web hacia el Api"}

###############################

@app.route("/UnidadFuente")
def UnidadFuente():
    try:
        # en la raiz, obtiene los datos del servicio faker
        url = f"http://api-service:{81}/UnidadFuente"
        res = requests.get(url).json()
        return render_template("unidad_fuentes.html", unidadFuentes = res)

    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consulta de datos web hacia el Api"}


@app.route("/UnidadFactorEmision")
def UnidadFactorEmision():
    try:
        # en la raiz, obtiene los datos del servicio faker
        url = f"http://api-service:{81}/UnidadFactorEmision"
        res = requests.get(url).json()
        return render_template("unidad_factor_emision.html", unidadFactoresEmision = res)

    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consulta de datos web hacia el Api"}


@app.route("/TiposGasGEI")
def TiposGasGEI():
    try:
        # en la raiz, obtiene los datos del servicio faker
        url = f"http://api-service:{81}/TiposGasGEI"
        res = requests.get(url).json()
        return render_template("tipos_gas_gei.html", tiposgasgei = res)

    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consulta de datos web hacia el Api"}


@app.route("/FactoresDeEmision")
def FactoresDeEmision():
    try:
        # en la raiz, obtiene los datos del servicio faker
        url = f"http://api-service:{81}/FactoresDeEmision"
        res = requests.get(url).json()
        return render_template("factores_de_emision.html", factoresdeemision = res)

    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consulta de datos web hacia el Api"}

@app.route("/Fuentes")
def Fuentes():
    try:
        # en la raiz, obtiene los datos del servicio faker
        url = f"http://api-service:{81}/Fuentes"
        res = requests.get(url).json()
        return render_template("fuentes.html", fuentes = res)

    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consulta de datos web hacia el Api"}

@app.route("/Consumos")
def Consumos():
    try:
        # en la raiz, obtiene los datos del servicio faker
        url = f"http://api-service:{81}/Consumos"
        res = requests.get(url).json()
        return render_template("consumos.html", consumos = res)

    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consulta de datos web hacia el Api"}

@app.route("/Consumos/sede/talca", methods=['GET'])
def Consumos_talca():
    try:
        # en la raiz, obtiene los datos del servicio faker
        url = f"http://api-service:{81}/Consumos/sede/?sede=talca"
        res = requests.get(url).json()
        return render_template("consumos_sede.html", consumos_str = res)

    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consulta de datos web hacia el Api"}

@app.route("/Consumos/sede/curico", methods=['GET'])
def Consumos_curico():
    try:
        curico = "curicó"
        # en la raiz, obtiene los datos del servicio faker
        url = f"http://api-service:{81}/Consumos/sede/?sede={curico}"
        res = requests.get(url).json()
        return render_template("consumos_sede.html", consumos_str = res)

    except Exception as e:
        logging.debug(e)
        return {"message":"Error en consulta de datos web hacia el Api"}


#@app.route("/Consumos/<sede>", methods=['GET'])
#def printSede(sede:str):
#    print(sede)

#@app.route(str)

##################

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