import pandas as pd
from datetime import datetime
from flask import Flask, jsonify
from sqlalchemy import create_engine, sql

import itertools
import json
import logging



def execute_queries(list_queries_string=[],querie_type=''):
    #engine = create_engine('postgresql://unicorn_user:magical_password@localhost/rainbow_database')
    db_name = "realizaApp"
    db_user = "realizaApp"
    db_pass = "realizaApp*"
    db_host = "database-service" #al trabajar con docker composed se debe agregar el nombre del servicio
    db_port = "5432"

    try:
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

    except Exception as e:
        logging.debug(e)

    finally:
    # Cerrar la conexión
        if conn is not None:
            conn.close()
            print("Conexión cerrada")

#########################
# Sacar data de un excel
def InsertCategoria():
    #Categoria Nombre, descripcion
    categorias = Categorias
    logging.debug(categorias)
    insertQueries = []
    for categoria in categorias:
        sql="" 
        #''' INSERT INTO public.categorias (id_categoria, nombre, descripcion) VALUES(0, '', ''); '''
        values = str(list(categoria.values())).replace("\\", "")[1:-1]
        sql = f""" insert into categorias (nombre) values({values});""".replace("\n","")
        
        insertQueries.append(sql)        
    
    #logging.debug(insertQueries[0])
    return insertQueries

######################### 

def Categorias():
    Categoria = {'Transporte',
                 'Emisiones indirectas de GEI por electricidad importada',
                 'Emisiones fugitivas',
                 'Emisiones directas de GEI',
                 'Productos que utiliza la organización',
                 } 
    return Categoria

def SubCategorias():
    SubCategoria = { 
        "Transporte": "Movilización de personas",
        "Emisiones Indirectas de GEI por electricidad importada": "Adquisición de electricidad",
        "Emisiones Fugitivas": "Refrigerante",
        "Emisiones directas de GEI": "Combustión Estacionaria",
        "Emisiones directas de GEI": " Combustión Móvil",
        "Productos que utiliza la organización": "Tratamiento y/o disposición de residuos",
        "Productos que utiliza la organización": "Bienes y servicios adquiridos",

    }
    return SubCategoria


def Alcances():
    Alcances = {'OTRAS EMISIONES INDIRECTAS DE GEI',
                 'EMISIONES INDIRECTAS POR CONSUMO Y DISTRIBUCIÓN DE ENERGÍA',
                 'EMISIONES DIRECTAS',
                 } 
    return Alcances

def UnidadFuentes():
    unidades = {'personas x kilómetros',
                 'MWh',
                 'kilogramos',
                 'metros cúbicos',
                 'toneladas',
                 'litros',
                 } 
    return unidades

######################### 


logging.debug(execute_queries(InsertCategoria(),"INSERT"))


'''def inserta_datos_excel(ruta_archivo_excel, host, puerto, usuario, password, db_name):
    try:
        client = InfluxDBClient(host, puerto, usuario, password, db_name)
        client.switch_database(db_name)
        measurement = "componentesMDW"

        # Leer los datos del archivo Excel especificando el motor 'openpyxl'
        df = pd.read_excel(ruta_archivo_excel, engine='openpyxl')
        #print(df.columns)

        # Eliminar duplicados basados en todas las columnas
        #df = df.drop_duplicates()

        # Eliminar datos existentes del measurement que coincidan con los datos del DataFrame
        eliminar_datos_measurement(client, measurement, df)

        for index, row in df.iterrows():
            cantidad = row['Cantidad']
            componente = row['Componentes']
            porcentaje = int(row['Porcentaje']) if pd.notnull(row['Porcentaje']) else None
            mes = row['Mes']
            ano = row['Ano']

            json_body = [
                {
                    "measurement": measurement,
                    "tags": {
                        "componente": componente,
                        "mes": mes,
                        "ano": ano,
                    },
                    "time": datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
                    "fields": {
                        "cantidad": cantidad,
                        "porcentaje": porcentaje
                    }
                }
            ]
            print(json_body)
            client.write_points(json_body)

        print("Datos insertados en InfluxDB con éxito.")

    except Exception as e:
        print(f"Error:  {e}")
'''
