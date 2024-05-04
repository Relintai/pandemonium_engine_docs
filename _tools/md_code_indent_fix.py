from os import listdir
from os.path import isfile, join
import os
import sys
from shutil import copyfile

input_folder = "./"
output_base_folder = "out"

processed_files = []

def read_file(path):
    f = open(path, "r")
    data = f.read()
    f.close()
    return data

def write_file(path, data):
    f = open(path, "w")
    f.write(data)
    f.close()

def ensure_dir(storage_path):
    if not os.path.exists(storage_path):
        os.makedirs(storage_path)

def reindent_code_block(cb, filename):
    lines = cb.split("\n")

    if len(lines) < 2:
        # Inline ```, like ``` func() ```
        return cb

    result = ""

    indent_type = ""
    min_indent_count = 0

    for i in range(len(lines)):
        l = lines[i]

        if l.strip() == "":
            continue

        if l[0] == " ":
            indent_type = " "
        elif l[0] == "\t":
            indent_type = "\t"
        else:
            # no indent
            # we are done, was already fixed
            return cb

        for j in range(len(l)):
            if l[j] == indent_type:
                min_indent_count += 1
            else:
                break

        break

    # Construct result
    for i in range(len(lines)):
        l = lines[i]

        if l.strip() == "":
            if i == len(lines) - 1:
                continue

            result += "\n"
            continue

        if len(l) < min_indent_count:
            print("something is wrong with input! len(l) < min_indent_count:" + l + " File: " + filename)
            return cb
        
        for j in range(min_indent_count):
            if l[j] != indent_type:
                print("something is wrong with input! l[j] != indent_type:" + l + " File: " + filename)
                return cb

        result += l[min_indent_count:] + "\n"

    return result
        
    

def process_md(inf):
    global processed_files

    print("Processing: " + inf)

    fd = read_file(inf)
    
    spl = fd.split("```")
    new_file_data = ""

    for i in range(len(spl)):
        if i % 2 == 0:
            # We are outside ```
            new_file_data += spl[i]
            continue

        # add back split off ```
        new_file_data += "```"

        new_file_data += reindent_code_block(spl[i], inf)

        # add back split off ```
        new_file_data += "```"
    
    #data = fd
    write_file(inf, new_file_data)
    processed_files.append(inf)


def process_dirs(proc_dir, skip_fol = []):
    cdirarr = os.listdir(proc_dir)

    for d in cdirarr:
        if d in skip_fol:
            continue

        p = os.path.abspath(proc_dir + d)

        if os.path.isdir(p):
            process_dirs(p + "/")
        else:
            if d.lower().endswith(".md"):
                process_md(p)


process_dirs(input_folder, [ output_base_folder, "_tools", ".git" ])
