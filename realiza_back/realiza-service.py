from flask import Flask, jsonify
from sqlalchemy import create_engine, sql
#from flask_sqlalchemy import SQLAlchemy
import pandas as pd

import itertools
import json
import logging

app = Flask(__name__)
logging.basicConfig(level=logging.DEBUG)
logging.debug("Realiza SERVICE INICIADO")


def execute_queries(list_queries_string=[],querie_type=''):
    #engine = create_engine('postgresql://unicorn_user:magical_password@localhost/rainbow_database')
    db_name = "realizaApp"
    db_user = "realizaApp"
    db_pass = "realizaApp*"
    db_host = "database-service" #al trabajar con docker composed se debe agregar el nombre del servicio
    db_port = "5432"

    try:
        #Error DEBUG:root:Not an executable object: 'SELECT VERSION()'
        db_string = f'postgresql://{db_user}:{db_pass}@{db_host}:{db_port}/{db_name}'
        db = create_engine(db_string) 
        conn = db.connect() 
        
        if (querie_type == 'SELECT'):
            for querie in list_queries_string:
                df = pd.read_sql_query(querie, db)
                # Convertir el DataFrame a JSON
                json_results = df.to_json(orient='records', indent=4)
            return json_results

        return {"message":"proceso ejecutado correctamente"}

    except Exception as e:
        logging.debug(e)

    finally:
    # Cerrar la conexión
        if conn is not None:
            conn.close()
            print("Conexión cerrada")


#####################################
# RUTAS DE LA API

@app.route("/obtenerCategorias")
def obtenerCategorias():
     try:
          querie_data= 'SELECT id_categoria, nombre, descripcion FROM Categorias;'
          data_profiles = json.loads(execute_queries([querie_data],"SELECT"))
          logging.debug(data_profiles)
          return json.dumps(data_profiles)
     except Exception:
		    return {"message":"error en consulta de datos en servicio realiza-service"}


@app.route("/SubCategorias")
def SubCategorias():
     try:
          #querie_data= 'SELECT * FROM subcategorias;'
          querie_data = '''select s.id_subcategoria, c.nombre as categoria, s.nombre, s.descripcion 
                        from subcategorias s inner join Categorias c on s.id_categoria = c.id_categoria'''
          
          data_profiles = json.loads(execute_queries([querie_data],"SELECT"))
          logging.debug(data_profiles)
          return json.dumps(data_profiles)
     except Exception:
		    return {"message":"error en consulta de datos en servicio realiza-service"}


@app.route("/Alcances")
def Alcances():
     try:
          querie_data= 'SELECT id_alcances, nombre, descripcion FROM alcances;'
          data_profiles = json.loads(execute_queries([querie_data],"SELECT"))
          logging.debug(data_profiles)
          return json.dumps(data_profiles)
     except Exception:
		    return {"message":"error en consulta de datos en servicio realiza-service"}


##############################

@app.route("/Proyectos")
def obtenerProyectos():
     try:
          querie_data= 'SELECT id_proyecto, nombre, descripcion FROM proyectos;'
          data_profiles = json.loads(execute_queries([querie_data],"SELECT"))
          logging.debug(data_profiles)
          return json.dumps(data_profiles)
     except Exception:
		    return {"message":"error en consulta de datos en servicio realiza-service"}

@app.route("/Campus")
def obtenerCampus():
     try:
          querie_data= '''SELECT c.id_campus, c.nombre as nombre_campus, c.id_proyecto, p.nombre as nombre_proyecto, c.huella_de_carbono, c.huella_hidrica, c.huella_financiera
                FROM campus c inner join proyectos p on c.id_proyecto = p.id_proyecto;'''
          data_profiles = json.loads(execute_queries([querie_data],"SELECT"))
          logging.debug(data_profiles)
          return json.dumps(data_profiles)
     except Exception:
		    return {"message":"error en consulta de datos en servicio realiza-service"}

@app.route("/Usuarios")
def obtenerUsuarios():
     try:
          querie_data= '''SELECT u.id_usuario, u.id_proyecto, u.id_campus, u.nombre, u.correo, u.tipo_usuario, u.activo, 
                        c.nombre as nombre_campus, p.nombre as nombre_proyecto
                        FROM usuario u INNER JOIN campus c on u.id_campus = c.id_campus 
                        INNER JOIN proyectos p ON c.id_proyecto = p.id_proyecto;'''
          data_profiles = json.loads(execute_queries([querie_data],"SELECT"))
          logging.debug(data_profiles)
          return json.dumps(data_profiles)
     except Exception:
		    return {"message":"error en consulta de datos en servicio realiza-service"}

##############################
@app.route("/UnidadFuente")
def obtenerUnidadFuente():
     try:
          querie_data= 'SELECT id_unidad_fuente, nombre, sigla FROM unidad_fuente;'
          data_profiles = json.loads(execute_queries([querie_data],"SELECT"))
          logging.debug(data_profiles)
          return json.dumps(data_profiles)
     except Exception:
		    return {"message":"error en consulta de datos en servicio realiza-service"}

@app.route("/UnidadFactorEmision")
def obtenerFactorEmision():
     try:
          querie_data= 'SELECT id_unidad_factor_emision, nombre from unidad_factor_emision;'
          data_profiles = json.loads(execute_queries([querie_data],"SELECT"))
          logging.debug(data_profiles)
          return json.dumps(data_profiles)
     except Exception:
        return {"message":"error en consulta de datos en servicio realiza-service"}
     
@app.route("/TiposGasGEI")
def obtenerTiposGasGEI():
     try:
          querie_data= 'SELECT id_gas_gei, nombre, sigla FROM tipos_gas_gei;'
          data_profiles = json.loads(execute_queries([querie_data],"SELECT"))
          logging.debug(data_profiles)
          return json.dumps(data_profiles)
     except Exception:
        return {"message":"error en consulta de datos en servicio realiza-service"}


############## RUN SERVER ####################
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000, debug=True)