import codecs
import csv
import pyodbc
import os
import os.path
import logging
from ast import literal_eval

from pythontestingframework_execute_tests.db.connections import mms_qa_akv, pool_pass_qa_akv, lt_udw_qa_akv
from pythontestingframework_execute_tests.common import keyvault

queries_folder = os.path.join(os.path.dirname(os.path.realpath(__file__)), "..", "queries")
tests_folder = os.path.join(os.path.dirname(os.path.realpath(__file__)), "..", "tests")


class Database:
    def __init__(self, connection):

        if isinstance(connection, str):
            connection = connection.split(',')
        (driver, server, database, trusted_connection, username, password) = connection
        logging.info("Attempting to connect...")
        self._conn = pyodbc.connect(driver=driver, host=server, database=database,
                                    trusted_connection=trusted_connection, user=username, password=password)
        self._conn.autocommit = True
        self._cursor = self._conn.cursor()
        logging.info("Connection to " + database + " database successful.")

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close()

    @property
    def connection(self):
        return self._conn

    @property
    def cursor(self):
        return self._cursor

    def commit(self):
        self.connection.commit()

    def close(self, commit=True):
        if commit:
            self.commit()
        self.connection.close()

    def execute(self, sql, params=None):
        self.cursor.execute(sql, params or ())

    def fetchall(self):
        return self.cursor.fetchall()

    def fetchone(self):
        return self.cursor.fetchone()

    def query(self, sql, params=None):
        self.cursor.execute(sql, params or ())
        return self.fetchall()

    def get_query_results(self, query_file_name):
        logging.info('Executing query: ' + query_file_name)
        self.execute(self.get_query_text(query_file_name))
        columns = [column[0] for column in self.cursor.description]
        records = []
        for row in self.cursor.fetchall():
            records.append(dict(zip(columns, row)))
        return records

    @staticmethod
    def get_query_text(file_name):
        file = open(os.path.join(queries_folder, file_name), mode='r')
        query_text = file.read()
        file.close()
        return query_text

    @staticmethod
    def get_connection(db_name, output_file=True, index=1):
        output_path = os.path.relpath(os.path.join(tests_folder, 'output.csv'))
        if output_file and os.path.exists(output_path):
            csvReader = csv.reader(codecs.open('output.csv', mode='rU', encoding='utf-16'))
            conn_row = str(list(csvReader)[index]).replace('"', '')
            print(conn_row)
            conn = literal_eval('(' + conn_row + ')')
        else:
            db_switcher = {
                'lt_udw_qa_akv': lt_udw_qa_akv,
                'pool_pass_qa_akv': pool_pass_qa_akv,
                'mms_qa_akv': mms_qa_akv
            }
            conn_no_creds = db_switcher.get(db_name, "Invalid database name!")
            (driver, server, database, trusted_connection) = conn_no_creds
            conn_creds = keyvault.get_database_credentials(db_name)
            (username, password) = conn_creds
            conn = (driver, server, database, trusted_connection, username, password)
        return conn
