import utils
import os
import pyodbc
import pandas as pd
import numpy as np
from . import config

def connect_db_create_cursor(database_conf_name):
    # Call to read the configuration file
    db_conf = utils.get_sql_config(config.sql_server_config, database_conf_name)
    # Create a connection string for SQL Server
    db_conn_str = 'Driver={};Server={};Database={};Trusted_Connection={};'.format(*db_conf)
    # Connect to the server and to the desired database
    db_conn = pyodbc.connect(db_conn_str)
    # Create a Cursor class instance for executing T-SQL statements
    db_cursor = db_conn.cursor()
    return db_cursor

def load_query(query_name):
    for script in os.listdir(config.input_dir):
        if query_name in script:
            with open(config.input_dir + '\\' + script, 'r') as script_file:
                sql_script = script_file.read()
            break
    return sql_script

def update_dim_Categories(cursor, table_name, db, schema):
    update_table_script = load_query('update_dim_{}'.format(table_name)).format(db=db, schema=schema, table_name = table_name)
    cursor.execute(update_table_script)
    cursor.commit()
    print(f"{db}.{schema}.{table_name} table has been updated")

def update_dim_Customers(cursor, table_name, db, schema):
    update_table_script = load_query('update_dim_{}'.format(table_name)).format(db=db, schema=schema, table_name = table_name)
    cursor.execute(update_table_script)
    cursor.commit()
    print(f"{db}.{schema}.{table_name} table has been updated")

def update_dim_Employees(cursor, table_name, db, schema):
    update_table_script = load_query('update_dim_{}'.format(table_name)).format(db=db, schema=schema, table_name = table_name)
    cursor.execute(update_table_script)
    cursor.commit()
    print(f"{db}.{schema}.{table_name} table has been updated")

def update_dim_Suppliers(cursor, table_name, db, schema):
    update_table_script = load_query('update_dim_{}'.format(table_name)).format(db=db, schema=schema, table_name = table_name)
    cursor.execute(update_table_script)
    cursor.commit()
    print(f"{db}.{schema}.{table_name} table has been updated")

def update_dim_Shippers(cursor, table_name, db, schema):
    update_table_script = load_query('update_dim_{}'.format(table_name)).format(db=db, schema=schema, table_name = table_name)
    cursor.execute(update_table_script)
    cursor.commit()
    print(f"{db}.{schema}.{table_name} table has been updated")

def update_dim_Region(cursor, table_name, db, schema):
    update_table_script = load_query('update_dim_{}'.format(table_name)).format(db=db, schema=schema, table_name = table_name)
    cursor.execute(update_table_script)
    cursor.commit()
    print(f"{db}.{schema}.{table_name} table has been updated")

def update_dim_Products(cursor, table_name, db, schema):
    update_table_script = load_query('update_dim_{}'.format(table_name)).format(db=db, schema=schema, table_name = table_name)
    cursor.execute(update_table_script)
    cursor.commit()
    print(f"{db}.{schema}.{table_name} table has been updated")

def update_dim_Territories(cursor, table_name, db, schema):
    update_table_script = load_query('update_dim_{}'.format(table_name)).format(db=db, schema=schema, table_name = table_name)
    cursor.execute(update_table_script)
    cursor.commit()
    print(f"{db}.{schema}.{table_name} table has been updated")

def update_fact_FactOrders(cursor, table_name, db, schema):
    update_table_script = load_query('update_fact_{}'.format(table_name)).format(db=db, schema=schema, table_name = table_name)
    cursor.execute(update_table_script)
    cursor.commit()
    print(f"{db}.{schema}.{table_name} table has been updated")