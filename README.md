# Pandemonium Engine documentation

This repository contains the source files of [Pandemonium Engine](https://pandemoniumengine.org)'s documentation, in the markdown markup language.

## Reading

### Hosted

This documentation is can be read directly using github (or my gitea mirror).

### Locally

#### Using python

If you have python installed, a locally readable version can be easily generated.

Clone the repository (or download as zip):

`git clone -b master https://github.com/Relintai/pandemonium_engine_docs.git`

Open a terminal in the root of the project, then run:

`python _tools/md_doc_gen.py`

A new `out` folder should appear, it has an index.html which can be opened in a browser directly by double
clicking it. It doesn't need a web server.

#### Using the engine itself

As a little fun, the engine has an http server built in, which can be used to browse and read the docs locally.

Clone the repository (or download as zip):

`git clone -b master https://github.com/Relintai/pandemonium_engine_docs.git`

Open a terminal in the `_tools/pdocs/` folder.

Either run `./cp_www.sh`, or create a `www` folder and copy everything (except the `_tools` folder) from the root of the project into it.

Then open the `_tools/pdocs/` project in a recent version of the pandemonium engine, run the project, and click or open the url shown.

Note that two different version of this docs hoster project is available in the [07_demo_projects/web/](/07_demo_projects/web/) folder.

## Disclaimer

Please note that rst -> md conversion is still work in progress, so some pages might look a bit broken.
Although all images should work, and it should be readable.

## Contributing changes

Pull Requests should use the `master` branch by default. Only make Pull Requests against other branches (e.g. `2.1` or `3.0`) if your changes only 
apply to that specific version of Pandemonium.

Though arguably less convenient to edit than a wiki, this Git repository is meant to receive pull requests to always improve the 
documentation, add new pages, etc. Having direct access to the source files in a revision control system is a 
big plus to ensure the quality of our documentation.

## License

All the content of this repository is licensed under the Creative Commons Attribution
3.0 Unported license ([CC BY 3.0](https://creativecommons.org/licenses/by/3.0/)) and is to be attributed to "Péter Magyar and the Pandemonium community, 
and Juan Linietsky, Ariel Manzur and the Godot community".

See [LICENSE.txt](/LICENSE.txt) for details.


The files in the `07_demo_projects/` folder are distributed under the MIT license:

Copyright (c) 2022-present Péter Magyar. \
Copyright (c) 2014-2022 Godot Engine contributors. \
Copyright (c) 2007-2022 Juan Linietsky, Ariel Manzur.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


