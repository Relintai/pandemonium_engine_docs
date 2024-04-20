

Introduction to Pandemonium development
=================================

This page is meant to introduce the global organization of Pandemonium Engine's
source code, and give useful tips for extending/fixing the engine on the
C++ side.

Architecture diagram
--------------------

The following diagram describes the architecture used by Pandemonium, from the
core components down to the abstracted drivers, via the scene
structure and the servers.

![](img/architecture_diagram.jpg

Debugging the editor with gdb
-----------------------------

If you are writing or correcting bugs affecting Pandemonium Engine's editor,
remember that the binary will by default run the project manager first,
and then only run the editor in another process once you've selected a
project. To launch a project directly, you need to run the editor by
passing the `-e` argument to Pandemonium Engine's binary from within your
project's folder. Typically:

```
    $ cd ~/myproject
    $ gdb pandemonium
    > run -e
```

Or:

```
    $ gdb pandemonium
    > run -e --path ~/myproject
```
