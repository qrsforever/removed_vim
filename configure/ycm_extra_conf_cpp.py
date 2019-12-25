import os

flags = [
        '-Wall',
        '-Wextra',
        '-Wno-long-long',
        '-Wno-variadic-macros',
        '-fexceptions',
        '-stdlib=libc++',
        '-std=c++11',
        '-x',
        'c++',
        '-I',
        '.',
        '-isystem',
        '/usr/include',
        '-isystem',
        '/usr/local/include',
        '-isystem',
        '/usr/include/c++/v1',
        ]

SOURCE_EXTENSIONS = ['.cpp', '.cxx', '.cc', '.c', '.m', '.mm']


def DirectoryOfThisScript():
    return os.path.dirname(os.path.abspath(__file__))


def IsHeaderFile(filename):
    extension = os.path.splitext(filename)[1]
    return extension in ['.h', '.hxx', '.hpp', '.hh']


SRC_DIR = [
        'your project subdir-1',
        'your project subdir-2/subdir-3',
        ]


def SearchHeaderDirs(path, working_directory):
    if not path.startswith('/'):
        path = os.path.join(working_directory, path)
    for root, dirs, files in os.walk(path):
        if os.path.basename(root) in ['include', 'inc', 'Include', 'Inc']:
            flags.append('-I')
            flags.append(root)
        else:
            for file in files:
                if IsHeaderFile(file):
                    flags.append('-I')
                    flags.append(root)
                    break


def Settings(filename, **kwargs):

    relative_to = DirectoryOfThisScript()

    for dir in SRC_DIR:
        SearchHeaderDirs(dir, relative_to)

    return {
      'flags': flags,
      'include_paths_relative_to_dir': relative_to,
    }
