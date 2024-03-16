from os import listdir
from os.path import isfile, join
import os
import sys
from shutil import copyfile

input_folder = "./"
output_base_folder = "out"
output_folder = output_base_folder + "/"

main_body_template = ""
index_body_template = ""

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

def categ_to_name(name):
    ns = name.split("_")

    try:
        # if it's an int, remove it, so sorting can be done via prefixing folders with numbers
        ii = int(ns[0])
        
        n = ns[1]
        for i in range(2, len(ns)):
            n += "_" + ns[i]

        name = n
    except:
        pass


    name = name.replace("_", " ").title()
    name = name.replace("2d", "2D").replace("3d", "3D").replace("Faq", "FAQ")

    return name

def link_to_name(name):
    name = name.split("/")[-1]
    name = name.replace(".md.html", "")

    ns = name.split("_")
    
    try:
        # if it's an int, remove it, so sorting can be done via prefixing folders with numbers
        ii = int(ns[0])
        
        n = ns[1]
        for i in range(2, len(ns)):
            n += "_" + ns[i]

        name = n
    except:
        pass

    name = name.replace("_", " ").title()
    name = name.replace("2d", "2D").replace("3d", "3D").replace("Faq", "FAQ")

    return name

def strip_path_sort_number(name):
    try:
        # if it's an int, remove it, so sorting can be done via prefixing folders with numbers
        ii = int(ns[0])
        
        n = ns[1]
        for i in range(2, len(ns)):
            n += "_" + ns[i]

        name = n
    except:
        pass

    return name

def path_to_document_name(name):
    name = name.removeprefix(os.getcwd() + "/out/")

    ns = name.split("/")

    final = ""

    for i in range(len(ns) - 1):
        final += strip_path_sort_number(ns[i].replace("_", " ")).title() + " / "

    final += strip_path_sort_number(ns[-1].replace(".md", "").replace("_", " ")).title()

    final = final.replace("2d", "2D").replace("3d", "3D").replace("Faq", "FAQ")

    return final


def process_md(inf, outf, depth):
    global processed_files

    fd = read_file(inf)

    dp = ""

    for i in range(depth):
        dp += "../"

    data = main_body_template.replace("DOCUMENT_PATH", dp)
    data = data.replace("DOCUMENT_TITLE", path_to_document_name(outf))
    data = data.replace("DOCUMENT_BODY", fd)
    
    write_file(outf + ".html", data)

    processed_files.append(outf + ".html")

def process_dir_copy(d, out_fol, depth):
    files = os.listdir(d)
    
    for f in files:
        inf = os.path.abspath(d + f)
        outf = os.path.abspath(out_fol + f)

        if os.path.isdir(inf):
            continue

        if f.lower().endswith(".md"):
            print("Processing: " + f)
            process_md(inf, outf, depth)
            continue

        #print(inf)
        #print(outf)

        print("Copying: " + inf)

        copyfile(inf, outf)

def process_dirs(proc_dir, out_fol, depth, skip_fol = []):
    cdirarr = os.listdir(proc_dir)

    for d in cdirarr:
        if d in skip_fol:
            continue

        p = os.path.abspath(proc_dir + d)
        out_p = os.path.abspath(out_fol + d)

        if os.path.isdir(p):
            ensure_dir(out_p)
            process_dirs(p + "/", out_p + "/", depth + 1)

            process_dir_copy(p + "/", out_p + "/", depth)  

def process_category(categ_dict, category_level):
    result = ""

    keys = list(categ_dict.keys())
    keys.sort()

    for k in keys:
        categ = categ_dict[k]

        if isinstance(categ, dict):
            result += "\n"

            for i in range(category_level):
                result += "#"

            result += " " + categ_to_name(k) + "\n" 
            result += "\n" 

            result += process_category(categ, category_level + 1)
        else:
            cs = categ.split(";")

            cs.sort()

            for c in cs:
                result += "\n"
                result += "[" + link_to_name(c) + "](" + c + ")"
                result += "\n"

    return result


main_body_template = read_file("./_tools/markdeep/main_body.md.html")
index_body_template = read_file("./_tools/markdeep/index_body.md.html")

ensure_dir(output_folder)
process_dirs(input_folder, output_folder, 1, [ output_base_folder, "_tools", ".git" ])

copyfile("./_tools/markdeep/slate.css", output_folder + "slate.css")
copyfile("./_tools/markdeep/markdeep.min.js", output_folder + "markdeep.min.js")

current_dir = os.getcwd() + "/out/"

files = []

for f in processed_files:
    files.append(f.removeprefix(current_dir))

file_categories = {}

for f in files:
    fs = f.split("/")

    d = file_categories

    for i in range(len(fs) - 1):
        if not fs[i] in d:
            d[fs[i]] = {}

        d = d[fs[i]]

    if fs[-2] in d:
        d[fs[-2]] = d[fs[-2]] + ";" + f
    else:
        d[fs[-2]] = f


fd = process_category(file_categories, 1)

data = index_body_template.replace("DOCUMENT_BODY", fd)
write_file("out/index.html", data)
