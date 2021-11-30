from os import environ as env
from azure.identity import ClientSecretCredential
from azure.keyvault.secrets import SecretClient
from azure.identity import DefaultAzureCredential

KEYVAULT_NAME_DEV = "ebi-keyvault-dev"
KEYVAULT_URI_DEV = f"https://{KEYVAULT_NAME_DEV}.vault.azure.net/"
KEYVAULT_NAME_QA = "ebi-keyvault-qa"
KEYVAULT_URI_QA = f"https://{KEYVAULT_NAME_QA}.vault.azure.net/"

db_username_secret_name = "dev-ebi-udw-testing-automation-svcacct-username"
db_password_secret_name = "dev-ebi-udw-testing-automation-svcacct-password"
adls_secret_name = "ebidatalakeblobqa"

_credential = DefaultAzureCredential()
_sc_dev = SecretClient(vault_url=KEYVAULT_URI_DEV, credential=_credential)
_sc_qa = SecretClient(vault_url=KEYVAULT_URI_QA, credential=_credential)


def get_secret_value(secret_name, environment="qa"):
    if environment=='dev':
        result = _sc_dev.get_secret(secret_name).value
    if environment=='qa':
        result = _sc_qa.get_secret(secret_name).value
    return result

"""
def get_database_credentials(db_name,username_secret_name = db_username_secret_name, password_secret_name = db_password_secret_name):
    db_switcher = {
        'lt_udw_qa_akv': (get_secret_value(username_secret_name, environment='dev'), get_secret_value(password_secret_name, environment='dev')),
        'pool_pass_qa_akv': ('pool_pass_qa', 'pool_pass_qa'),
        'mms_qa_akv': ('mms_qa', 'mms_qa')
    }
    creds = db_switcher.get(db_name, "Invalid database name!")
    # print("db username= " + db_username + "; db password = " + db_password + ";")
    # print(env.get("IsEncrypted", ""))
    return creds
"""


def get_database_credentials(db_name,username_secret_name = db_username_secret_name, password_secret_name = db_password_secret_name):
    creds = ('InformaticaUser','Informatic@1')
    # print("db username= " + db_username + "; db password = " + db_password + ";")
    # print(env.get("IsEncrypted", ""))
    return creds
