import logging
import json
from pandas.testing import assert_frame_equal


def get_errors_number(cursor, index=1):
    errors_number = 0
    for row in cursor.fetchall():
        if int(row[index]) != 0:
            errors_number += 1
            logging.info('\n' + str(row))
    return errors_number


def get_diff(list1, list2):
    diff = list(set(freeze(list1)) - set(freeze(list2)))
    return diff


def to_json(obj):
    json_obj = json.dumps(list(obj), indent=4, sort_keys=True, default=str)
    return json_obj


def lists_equal(list1, list2):
    diff12 = get_diff(list1, list2)
    diff21 = get_diff(list2, list1)
    print("List1 elements not present in List2({} total):\n {}".format(len(diff12), to_json(diff12)) + "\n")
    print("List2 elements not present in List1({} total):\n {}".format(len(diff21), to_json(diff21)) + "\n")
    if len(list1) != len(list2):
        print(
            "The lists have different length: list1 length is {} and list2 length is {}".format(len(list1), len(list2)))
        return False
    else:
        if len(diff12) + len(diff21) != 0:
            print("Elements of the lists are not equal!")
            return False
    print("Elements of the lists are equal!")
    return True


def freeze(obj):
    if isinstance(obj, dict):
        return frozenset((key, freeze(value)) for key, value in obj.items())
    elif isinstance(obj, list):
        return tuple(freeze(value) for value in obj)
    return obj


def get_duplicates(obj):
    """ Check if given list contains any duplicates """
    duplicates = []
    set_of_elements = set()
    for element in freeze(obj):
        if element in set_of_elements:
            duplicates.append(element)
        else:
            set_of_elements.add(element)
    print('Duplicates in target:\n' + to_json(duplicates))
    return duplicates


def dataframes_equal(df1, df2):
    """print("\n5 random rows of Source dataframe: ")
    print(df1.sample(n=5))
    print("\n5 random rows of Target dataframe: ")
    print(df1.sample(n=5))"""

    if df1.size != df2.size:
        print("\n\n\n\n\n")
        print("\033[31;1;4m" + "\nThe row count of df1 and df2 is : df1 " + str(df1.shape[0]) + "\n df2 is " + str(
            df2.shape[0]) + "\033[0m")
        print("\033[31;1;4m" + "\nThe column count of df1 and df2 is : df1 " + str(df1.shape[1]) + "\n df2 is " + str(
            df2.shape[1]) + "\033[0m")

        print("\033[31;1;4m" + "\n The column or Row count between source and target are not matching" + "\033[0m")
        print("\n\n\n\n\n")

        return False
    else:
        try:
            print(df1.dtypes)
            print("\n\n")
            print(df2.dtypes)

            assert_frame_equal(df1.convert_dtypes(), df2.convert_dtypes(), check_names=False, check_dtype=False)
            return True
        except AssertionError:
            """
            diff12 = df1[df2.ne(df1).any(axis=1)].dropna(axis=0)
            # .to_json(orient='records')[1:-1].replace('},{', '} {')
            diff21 = df2[df1.ne(df2).any(axis=1)].dropna(axis=0)
            # .to_json(orient='records')[1:-1].replace('},{', '} {')
            """
            diff12 = df1.compare(df2, align_axis=0)
            diff21 = df2.compare(df1, align_axis=0)
            print("\nDifferent records in json format between first and second datasets: \n" + diff12)
            print("\n\n\n\n\n")
            print("\nDifferent records in json format between second and first datasets: \n" + diff21)
            return False
