# This function is not intended to be invoked directly. Instead it will be
# triggered by an orchestrator function.
# Before running this sample, please:
# - create a Durable orchestration function
# - create a Durable HTTP starter function
# - add azure-functions-durable to requirements.txt
# - run pip install -r requirements.txt

import pytest
import sys
from os.path import dirname, abspath


def main(name: str) -> str:
    sys.path.append(dirname(dirname(dirname(abspath(__file__)))))
    args_str = "./pythontestingframework_execute_tests/tests/"
    args = args_str.split(" ")
    pytest.main(args)
    return f"Hello {name}!"
