import pytest
import csv
import codecs
import os

tests_folder = os.path.dirname(os.path.realpath(__file__))

from pythontestingframework_execute_tests.db.Database import Database
from pythontestingframework_execute_tests.common import utils


def get_data(file_name, index=0):
    values = []
    csvReader = csv.reader(codecs.open(os.path.join(tests_folder,'output.csv'), mode='rU', encoding='utf-16'))
    for SP in next(csvReader):
        print(SP)
        with open(os.path.join(tests_folder,file_name), newline='', mode="r", encoding='utf-8') as f:
            reader = csv.reader(f)
            for row in reader:
                if SP in row[len(row) - 1]:
                    if index == 0:
                        values.append(row[0])
                    else:
                        del row[:index]
                        print(row)
                        values.append(row)
    return values


@pytest.mark.parametrize("values", get_data('test_data_one_db.csv', index=1),
                         ids=get_data('test_data_one_db.csv'))
def test_one_database(values):
    #   Step 1: Get connection string from command line argument if defined
    #    if db_conn == "default db_conn":
    #    db_conn = connections.lt_udw_qa_conn

    db = Database(Database.get_connection(values[0], output_file=False))

    #   Step 2: Get data from source table
    records_source = db.get_query_results(values[1])

    #   Step 3: Get data from target table
    records_target = db.get_query_results(values[2])

    #   Step 4: Assert that the lists are equal and target table doesn't have duplicates
    assert utils.lists_equal(records_source, records_target)
    assert len(utils.get_duplicates(records_target)) == 0


@pytest.mark.parametrize("values", get_data('test_data_two_dbs.csv', index=1),
                         ids=get_data('test_data_two_dbs.csv'))
def test_two_databases(values):
    #   Step 1: Connect to the first database
    db1 = Database(Database.get_connection(values[0], output_file=False))

    #   Step 2: Get data from source table
    records_source = db1.get_query_results(values[1])

    #   Step 3: Connect to the second database
    db2 = Database(Database.get_connection(values[2], output_file=False))

    #   Step 4: Get data from target table
    records_target = db2.get_query_results(values[3])

    #   Step 4: Assert that the lists are equal and target table doesn't have duplicates
    assert utils.lists_equal(records_source, records_target)
    assert len(utils.get_duplicates(records_target)) == 0