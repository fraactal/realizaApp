from flask import Flask, jsonify
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


@app.route('/obtenerConsumos')
def get_profiles():
	querie_data= 'SELECT * FROM CONSUMOS;'
	try:
		data_profiles = json.loads(
			execute_queries([querie_data],"SELECT"))
		return json.dumps(data_profiles)
	except Exception:
		return {"message":"error en consulta de datos en servicio realiza-service"}


############## RUN SERVER ####################
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000, debug=True)