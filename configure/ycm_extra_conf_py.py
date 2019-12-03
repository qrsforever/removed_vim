import os.path as p

DIR_OF_THIS_SCRIPT = p.abspath(p.dirname(__file__))

def PythonSysPath(**kwargs):
    sys_path = kwargs['sys_path']

    dependencies = [
        p.join(DIR_OF_THIS_SCRIPT, 'python')
    ]

    sys_path[0:0] = dependencies

    return sys_path
