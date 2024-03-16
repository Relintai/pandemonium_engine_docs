
# Compiling for the Web

This page describes how to compile HTML5 editor and export template binaries from source. If you're looking 
to export your project to HTML5 instead, read `doc_exporting_for_web`.


## Requirements

To compile export templates for the Web, the following is required:

-  `Emscripten 1.39.9+ ( https://emscripten.org )`.
-  `Python 3.5+ ( https://www.python.org/ )`.
-  `SCons 3.0+ ( https://www.scons.org )` build system.


To get the Pandemonium source code for compiling, see `doc_getting_source`.
For a general overview of SCons usage for Pandemonium, see `doc_introduction_to_the_buildsystem`.

## Building export templates

Before starting, confirm that `emcc` is available in your PATH. This is
usually configured by the Emscripten SDK, e.g. when invoking `emsdk activate`
and `source ./emsdk_env.sh`/`emsdk_env.bat`.

Open a terminal and navigate to the root directory of the engine source code.
Then instruct SCons to build the JavaScript platform. Specify `target` as
either `release` for a release build or `release_debug` for a debug build:

```
    scons platform=javascript tools=no target=release
    scons platform=javascript tools=no target=release_debug
```

By default, the `JavaScript singleton ( doc_javascript_eval )` will be built
into the engine. Official export templates also have the JavaScript singleton
enabled. Since `eval()` calls can be a security concern, the
`javascript_eval` option can be used to build without the singleton:

```
    scons platform=javascript tools=no target=release javascript_eval=no
    scons platform=javascript tools=no target=release_debug javascript_eval=no
```

The engine will now be compiled to WebAssembly by Emscripten. Once finished,
the resulting file will be placed in the `bin` subdirectory. Its name is
`pandemonium.javascript.opt.zip` for release or `pandemonium.javascript.opt.debug.zip`
for debug.

Finally, rename the zip archive to `webassembly_release.zip` for the
release template:

```
    mv bin/pandemonium.javascript.opt.zip bin/webassembly_release.zip
```

And `webassembly_debug.zip` for the debug template:

```
    mv bin/pandemonium.javascript.opt.debug.zip bin/webassembly_debug.zip
```

## Threads

The default export templates do not include threads support for
performance and compatibility reasons. See the
`export page ( doc_javascript_export_options )` for more info.

You can build the export templates using the option `threads_enabled=yes` to enable threads support:

```
    scons platform=javascript tools=no threads_enabled=yes target=release
    scons platform=javascript tools=no threads_enabled=yes target=release_debug
```

Once finished, the resulting file will be placed in the `bin` subdirectory.
Its name will have the `.threads` suffix.

Finally, rename the zip archives to `webassembly_release_threads.zip` for the release template:

```
    mv bin/pandemonium.javascript.opt.threads.zip bin/webassembly_threads_release.zip
```

And `webassembly_debug_threads.zip` for the debug template:

```
    mv bin/pandemonium.javascript.opt.debug.threads.zip bin/webassembly_threads_debug.zip
```

## Building the Editor


It is also possible to build a version of the Pandemonium editor that can run in the
browser. The editor version requires threads support and is not recommended
over the native build. You can build the editor with:

```
    scons platform=javascript tools=yes threads_enabled=yes target=release_debug
```

Once finished, the resulting file will be placed in the `bin` subdirectory.
Its name will be `pandemonium.javascript.opt.tools.threads.zip`. You can upload the
zip content to your web server and visit it with your browser to use the editor.

Refer to the `export page ( doc_javascript_export_options )` for the web
server requirements.
