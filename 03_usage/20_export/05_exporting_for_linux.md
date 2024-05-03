

# Exporting for Linux

See also:

    This page describes how to export a Pandemonium project to Linux.
    If you're looking to compile editor or export template binaries from source instead,
    read `doc_compiling_for_x11`.

The simplest way to distribute a game for PC is to copy the executable
(`pandemonium`), compress the folder and send it to someone else. However, this is
often not desired.

Pandemonium offers a more elegant approach for PC distribution when using the export
system. When exporting for Linux, the exporter takes all the project files and
creates a `data.pck` file. This file is bundled with a specially optimized
binary that is smaller, faster and does not contain the editor and debugger.
