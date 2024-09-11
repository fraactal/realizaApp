from flask import Flask, jsonify, request
from sqlalchemy import create_engine, sql
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

@app.route("/")
def obtenerCategorias():
     try:
          querie_data= 'SELECT id_categoria, nombre, descripcion FROM Categorias;'
          data_profiles = json.loads(execute_queries([querie_data],"SELECT"))
          logging.debug(data_profiles)
          return json.dumps(data_profiles)
     except Exception:
		    return {"message":"error en consulta de datos en servicio realiza-service"}

@app.route("/Categorias")
def Categorias():
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

@app.route("/FactoresDeEmision")
def obtenerFactoresDeEmisionI():
     try:
          querie_data= '''
          SELECT 
          fde.id_factor_emision, fde.id_Fuente, f.nombre as fuente_emision, fde.origen_del_fe, fde.incertidumbre,
          ufe.nombre as unidad_fuente,  -- unidad_factor_emision
          vfe.valor, -- valor_unidad_x_factor_emision
          tgg.sigla as gei, tgg.nombre as nombre_gei -- tipos_gas_gei
          -- fde.combustible, fde.id_unidad_factor_emision, ufe.id_unidad_factor_emision, vfe.id_factor_emision, vfe.id_gas_gei, 
          from factor_de_emision fde 
          inner join unidad_factor_emision ufe on fde.id_unidad_factor_emision = ufe.id_unidad_factor_emision
          inner join valor_unidad_x_factor_emision vfe on fde.id_factor_emision = vfe.id_factor_emision
          inner join tipos_gas_gei tgg on vfe.id_gas_gei = tgg.id_gas_gei 
          inner join fuente f on fde.id_fuente = f.id_fuente;
          '''
          data_profiles = json.loads(execute_queries([querie_data],"SELECT"))
          logging.debug(data_profiles)
          return json.dumps(data_profiles)
     except Exception:
        return {"message":"error en consulta de datos en servicio realiza-service"}

@app.route("/Fuentes")
def Fuentes():
     try:
          querie_data= '''
          
          select id_fuente, f.nombre as Fuente, uf.nombre as Unidad, uf.sigla as Sigla_unidad, 
          a.nombre as Alcance, c.nombre as Categoria, s.nombre as SubCategoria
          from fuente f
          inner join unidad_fuente uf on f.id_unidad_fuente = uf.id_unidad_fuente 
          inner join alcances a on a.id_alcances = f.id_alcances 
          inner join categorias c on f.id_categoria = c.id_categoria 
          inner join subcategorias s on s.id_subcategoria = f.id_subcategoria 
          
          '''
          data_profiles = json.loads(execute_queries([querie_data],"SELECT"))
          logging.debug(data_profiles)
          return json.dumps(data_profiles)
     except Exception:
        return {"message":"error en consulta de datos en servicio realiza-service"}

@app.route("/Consumos")
def Consumos():
     try:
          querie_data= '''
               select c.id_consumo, f.nombre as fuente, c.cantidad_fuente, c.fecha, c.link_respaldo ,
               c.comentarios, c.huellachile, camp.nombre as campus
               from consumos c 
               inner join fuente f on f.id_fuente = c.id_fuente 
               inner join campus camp on c.id_campus = camp.id_campus;
          '''
          data_profiles = json.loads(execute_queries([querie_data],"SELECT"))
          #logging.debug(data_profiles)
          return json.dumps(data_profiles)
     except Exception:
        return {"message":"error en consulta de datos en servicio realiza-service"}

@app.route("/Consumos/sede/")
def Consumos_sede():
     try:
          sede = request.args.get('sede', type = str)
          logging.debug(f"realiza-back-service /Consumos/sede/: {sede}")
          querie_data= f'''
          select sum(vfe.valor) as sumaFactorEmision, (sum(vfe.valor)*c.cantidad_fuente) as emision, ufe.nombre as unidadFactor, uf.nombre as Unidadfuente, -- uf.sigla ,
          to_char(c.fecha, 'DD/MM/YY') as fecha 
          , f.nombre as fuente_emision,c.cantidad_fuente, camp.nombre as campus, c.id_consumo, a.nombre as alcance, c2.nombre as categoria
          from factor_de_emision fde 
          inner join unidad_factor_emision ufe on fde.id_unidad_factor_emision = ufe.id_unidad_factor_emision
          inner join valor_unidad_x_factor_emision vfe on fde.id_factor_emision = vfe.id_factor_emision
          inner join tipos_gas_gei tgg on vfe.id_gas_gei = tgg.id_gas_gei 
          inner join fuente f on fde.id_fuente = f.id_fuente
          inner join unidad_fuente uf  on uf.id_unidad_fuente = f.id_unidad_fuente 
          inner join consumos c on c.id_fuente = f.id_fuente 
          inner join campus camp on camp.id_campus  = c.id_campus
          inner join alcances a on a.id_alcances = f.id_alcances 
          inner join categorias c2 on c2.id_categoria = f.id_categoria 
          where lower(camp.nombre) = '{sede.lower()}'
          group by f.nombre,  c.cantidad_fuente, camp.nombre, 
          c.id_consumo, unidadFactor, uf.nombre, uf.sigla, a.nombre, c2.nombre
          order by c.id_consumo asc;
          '''

          data_profiles = json.loads(execute_queries([querie_data],"SELECT"))
          #logging.debug(data_profiles)
          return json.dumps(data_profiles)
     except Exception:
        return {"message":"error en consulta de datos en servicio realiza-service"}
     

'''
     The URL parameters are available in request.args, which is an ImmutableMultiDict that has a get method, with optional parameters for default value (default) and type (type) - which is a callable that converts the input value to the desired format. (See the documentation of the method for more details.)

     from flask import request

     @app.route('/parametro/')
     def my_route():
          page = request.args.get('sede', type = str)
          #filter = request.args.get('filter', default = '*', type = str) 
          #logging.debug("Parametro BACK: ", page) 
          return page

     Examples with the code above:

     /my-route?sede=34               -> page: 34  filter: '*'
     /my-route                       -> page:  1  filter: '*'
     /my-route?sede=10&filter=test   -> page: 10  filter: 'test'
     /my-route?sede=10&filter=10     -> page: 10  filter: '10'
     /my-route?sede=*&filter=*       -> page:  1  filter: '*'
'''


############## RUN SERVER ####################
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000, debug=True)