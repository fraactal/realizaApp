from flask import Flask, jsonify
from faker import Faker
from sqlalchemy import create_engine, sql
import pandas as pd

import itertools
import json
import logging

app = Flask(__name__)
faker = Faker()
logging.basicConfig(level=logging.DEBUG)
logging.debug("FAKER SERVICE INICIADO")

def randomData():
    insertQueries = []
    profiles =[ dict(itertools.islice(faker.profile().items(),6)) for data in range(13)]
    for profile in profiles:
        sql=""
        for llave, valor in profile.items():
            if llave == 'current_location':
                coordinates = [ str(coordinate) for coordinate in valor ]
                profile.update(current_location = json.dumps({"coordinates":coordinates}))
        
        values = str(list(profile.values())).replace("\\", "")[1:-1]
        sql = f""" insert into profile (job, company, ssn, 
            residence, current_location, blood_group) 
            values({values});""".replace("\n","")
        
        insertQueries.append(sql)        
        
    #logging.debug(insertQueries[0])
    return insertQueries


def execute_queries(list_queries_string=[],querie_type=''):
    #engine = create_engine('postgresql://unicorn_user:magical_password@localhost/rainbow_database')
    db_name = "rainbow_database"
    db_user = "unicorn_user"
    db_pass = "magical_password"
    db_host = "database-service" #al trabajar con docker composed se debe agregar el nombre del servicio
    db_port = "5432"

    try:
        #Error DEBUG:root:Not an executable object: 'SELECT VERSION()'
        db_string = f'postgresql://{db_user}:{db_pass}@{db_host}:{db_port}/{db_name}'
        db = create_engine(db_string) 
        conn = db.connect() 

        #Query es insert
        if(querie_type=='INSERT'):
            logging.debug("Dentro del INSERT")
            for querie in list_queries_string:
                logging.debug(conn.execute(sql.text(querie)).rowcount)
                conn.commit() #Commit a cada insert
        
        if (querie_type == 'SELECT'):
            for querie in list_queries_string:
                df = pd.read_sql_query(querie, db)
                # Convertir el DataFrame a JSON
                json_results = df.to_json(orient='records', indent=4)
            return json_results
        
        if querie_type == 'DELETE':
            for querie in list_queries_string:
                data_profiles = conn.execute(sql.text(querie))
                conn.commit() #Commit a cada insert

        return {"message":"proceso ejecutado correctamente"}
    
        #data = conn.execute(sql.text("SELECT VERSION();"))
        ##data = db.execute("SELECT version()")
        #for item in data:
            #logging.debug(item)

    except Exception as e:
        #return(str("Error en conectar Base de Datos."))
        logging.debug(e)

    finally:
    # Cerrar la conexión
        if conn is not None:
            #cursor.close()
            conn.close()
            print("Conexión cerrada")

@app.route('/crearRegistros')
def createProfile():
    try:
        result_query = execute_queries(randomData(),"INSERT")
        return result_query
        #return execute_queries(randomData())
    except Exception as e:
        return(str("Error en endpoint de crear registros"),e)


@app.route('/obtenerRegistros')
def get_profiles():
	querie_data= 'SELECT * FROM profile;'
	try:
		data_profiles = json.loads(
			execute_queries([querie_data],"SELECT"))
		return json.dumps(data_profiles)
	except Exception:
		return {"message":"error en consulta de datos en servicio faker-service"}

#Se pitea todos los registros XD
@app.route('/borrarRegistros')
def delete_profiles():
	querie_data= 'DELETE FROM profile;'
	try:
		data_profiles =  execute_queries([querie_data],"DELETE")
		return json.dumps(data_profiles)
	except Exception:
		return {"message":"error en eliminacion de datos en servicio faker-service"}

############## RUN SERVER ####################
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000, debug=True)