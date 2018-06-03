"""
General YCM config for C/C++ files.
This should be replaced with a project-specific file.
"""

import os

COMMON_FLAGS = [
    '-Wall',
    '-Wextra',
    '-Werror',

    '-g',
    '-D', 'DEBUG',

    '-isystem', '/usr/include',
    '-isystem', '/usr/local/include',

    '-I', '.'
]

CPP_FLAGS = [
    '-std=c++11',
    '-x', 'c++',
    '-fexceptions',
    '-I', '/usr/include/c++/8.1.0'
]

C_FLAGS = [
    '-std=gnu99',
    '-x', 'c'
]


def is_c_file(filename):
    basename, extension = os.path.splitext(filename)
    if extension == '.h':
        if os.path.exists(basename + '.c'):
            return True
        # If it's a lone header file we assume it's a C++ file for simplicity.
    elif extension == '.c':
        return True
    return False


def directory_of_this_script():
    return os.path.dirname(os.path.abspath(__file__))

def make_relative_paths_in_flags_absolute(flags, working_directory):
    if not working_directory:
        return list(flags)
    new_flags = []
    make_next_absolute = False
    # WORK OUT WHAT THESE DO (the rules governing how you can use them).
    path_flags = ['-isystem', '-I', '-iquote', '--sysroot=']

    # What we should do:
    # Split flags if they start with a path_flag but aren't the entire flag
    # Then, iterate through zip(flags, flags[1:])
    # If first is path flag, and second not starts with '/', attach working
    # directory to it.

    for flag in flags:
        new_flag = flag

        if make_next_absolute:
            make_next_absolute = False
            # if we didn't start with a '/' then we have to make it absolute.
            if not flag.startswith('/'):
                new_flag = os.path.join(working_directory, flag)

        # For each -isystem, -I, etc.
        for path_flag in path_flags:
            if flag == path_flag:
                # We have to make the following flag absolute.
                make_next_absolute = True
                break

            # If we started with it (so there was no space, e.g. -Isrc)
            if flag.startswith(path_flag):
                # Grab the actual path, tossing out the flag
                path = flag[len(path_flag):]
                # make the new flag the path_flag and an 'absolute' path
                new_flag = path_flag + os.path.join(working_directory, path)
                break

        if new_flag:
            new_flags.append(new_flag)
    return new_flags

# This is the entry point; this function is called by ycmd to produce flags for
# a file.
def FlagsForFile(filename, **kwargs):
    relative_to = directory_of_this_script()

    if is_c_file(filename):
        flags = COMMON_FLAGS + C_FLAGS
    else:
        flags = COMMON_FLAGS + CPP_FLAGS

    final_flags = make_relative_paths_in_flags_absolute(flags, relative_to)

    return {
        'flags': final_flags,
        'do_cache': True
    }
