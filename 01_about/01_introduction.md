

# Introduction

```
func _ready():
    $Label.text = "Hello world!"
```

Welcome to the official documentation of Pandemonium Engine, the free and open source
community-driven 2D and 3D game engine! Behind this mouthful, you will find a
powerful yet user-friendly tool that you can use to develop any kind of game,
for any platform and with no usage restriction whatsoever.

This page gives a broad presentation of the engine and of the contents
of this documentation, so that you know where to start if you are a beginner or
where to look if you need info on a specific feature.

Pandemonium Engine is a fork of the [Godot Engine](https://godotengine.org/) (specifically the  
[3.x](https://github.com/godotengine/godot/commits/3.x) branch). With heavy modifications.

Even though lots of things have been changed, most tutorials for godot should work with minimal tweaks.

## About Pandemonium Engine

A game engine is a complex tool, and it is therefore difficult to present Pandemonium
in a few words. Here's a quick synopsis, which you are free to reuse
if you need a quick writeup about Pandemonium Engine.

    Pandemonium Engine is a feature-packed, cross-platform game engine to create 2D
    and 3D games from a unified interface. It provides a comprehensive set of
    common tools, so users can focus on making games without having to
    reinvent the wheel. Games can be exported in one click to a number of
    platforms, including the major desktop platforms (Linux, macOS, Windows)
    as well as mobile (Android, iOS) and web-based (HTML5) platforms.

    Pandemonium is completely free and open source under the permissive MIT
    license. No strings attached, no royalties, nothing. Users' games are
    theirs, down to the last line of engine code. Pandemonium's development is fully
    independent and community-driven, empowering users to help shape their
    engine to match their expectations. It is supported by the 
    [Software Freedom Conservancy](https://sfconservancy.org) not-for-profit.

For a more in-depth view of the engine, you are encouraged to read this
documentation further, especially the 
[step by step](../index.html#tutorials/stepbystep) tutorial.

## About the documentation

This documentation is continuously worked on. It is edited via text files in the
markdown language and then compiled into a static website / offline document using 
a simple python script in the repository's 
[_tools](https://github.com/Relintai/pandemonium_engine_docs/tree/master/_tools) folder.

It's using [markdeep](https://casual-effects.com/markdeep/) for rendering it's final html output.

Note:

- You can contribute to Pandemonium's documentation by opening issue tickets
  or sending patches via pull requests on its GitHub
  [source repository](https://github.com/Relintai/pandemonium_engine_docs).

All the contents are under the permissive Creative Commons Attribution 3.0
[CC-BY 3.0](https://creativecommons.org/licenses/by/3.0/) license, with
attribution to "Péter Magyar and the Pandemonium community, and Juan Linietsky, Ariel Manzur and the Godot community".

## Organization of the documentation

This documentation is organized in five sections with an impressively
unbalanced distribution of contents – but the way it is split up should be
relatively intuitive:

- The [About](../index.html#about) section contains this introduction as well as
  information about the engine, its history, its licensing, authors, etc. It
  also contains the [FAQ](02_faq.md.html).
- The [Tutorials](../index.html#tutorials) section can be read as needed,
  in any order. It contains feature-specific tutorials and documentation.
- The [Usage](../index.html#usage) section is the *raison d'être* of this
  documentation, as it contains all the necessary information on using the
  engine to make games.
- [Modules](../index.html#modules). Some of the engine's functionality is in modules that can be turned on or off 
  when compiling. This section contains information about these.
- The [Engine Development](../index.html#enginedevelopment) section is intended for advanced users and contributors
  to the engine development, with information on compiling the engine,
  developing C++ modules or editor plugins.
- The [Community](../index.html#community) section gives information related to contributing to
  engine development and the life of its community, e.g. how to report bugs,
  help with the documentation, etc. It also points to various community channels
  like IRC and Discord and contains a list of recommended third-party tutorials
  outside of this documentation.

In addition to this documentation you may also want to take a look at the
various [Pandemonium demo projects](https://github.com/Relintai/pandemonium_demo_projects).

Have fun reading and making games with Pandemonium Engine!
