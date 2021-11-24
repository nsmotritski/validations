import os
import pytest
import tempfile
from azure.storage.blob import ContainerClient
from _pytest.junitxml import LogXML
from pythontestingframework_execute_tests.common import keyvault

reports_folder = os.environ.get("REPORTS_FOLDER")

def get_files(directory):
    with os.scandir(directory) as entries:
        for entry in entries:
            if entry.is_file():
                yield entry


def upload_latest_report(files, connection_string, container_name):
    container_client = ContainerClient.from_connection_string(connection_string, container_name)
    print("Copying report to datalake storage")
    latest_file = max(files, key=os.path.getctime)
    print(latest_file)
    blob_client = container_client.get_blob_client(latest_file.name)
    with open(latest_file.path, "rb") as data:
        blob_client.upload_blob(data)
        print(f'{latest_file.name} uploaded to blob storage')


def pytest_configure(config):
    if config.option.xmlpath:  # was passed via config or command line
        return  
    if not hasattr(config, 'slaveinput'):
        with tempfile.NamedTemporaryFile(suffix='.xml', dir=reports_folder) as tmpfile:
            xmlpath = tmpfile.name
            config._xml = LogXML(xmlpath, config.option.junitprefix, config.getini('junit_suite_name'))
            config.pluginmanager.register(config._xml)


def pytest_unconfigure():
    secret = keyvault.get_secret_value(secret_name="ebidatalakeblobqa-full-connection-string", environment='qa')
    files = get_files(reports_folder)
    upload_latest_report(files, secret, "automated-testing-results")


def pytest_addoption(parser):
    parser.addoption("--DBDesc", action="store", default="default DBDesc")
    parser.addoption("--DBServer", action="store", default="default DBServer")
    parser.addoption("--DBName", action="store", default="default DBName")
    parser.addoption("--DBStatus", action="store", default="default DBStatus")
    parser.addoption("--DBUser", action="store", default="default DBUser")
    parser.addoption("--DBPass", action="store", default="default DBPass")
    parser.addoption("--db_conn", action="store", default="default db_conn")
    parser.addoption("--objfilter", action="store", default="All")


@pytest.fixture
def db_conn(request):
    return request.config.getoption("--db_conn")


@pytest.fixture
def objfilter(request):
    return request.config.getoption("--objfilter")


@pytest.fixture
def DBDesc(request):
    return request.config.getoption("--DBDesc")


@pytest.fixture
def DBServer(request):
    return request.config.getoption("--DBServer")


@pytest.fixture
def DBName(request):
    return request.config.getoption("--DBName")


@pytest.fixture
def DBStatus(request):
    return request.config.getoption("--DBStatus")


@pytest.fixture
def DBUser(request):
    return request.config.getoption("--DBUser")


@pytest.fixture
def DBPass(request):
    return request.config.getoption("--DBPass")
