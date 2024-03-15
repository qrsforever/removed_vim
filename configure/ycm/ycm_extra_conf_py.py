import os

DIR_OF_THIS_SCRIPT = os.path.abspath(os.path.dirname(__file__))


def PythonSysPath(**kwargs):
    sys_path = kwargs['sys_path']

    dependencies = [
        os.path.join(DIR_OF_THIS_SCRIPT, 'python')
    ]

    sys_path[0:0] = dependencies

    return sys_path
