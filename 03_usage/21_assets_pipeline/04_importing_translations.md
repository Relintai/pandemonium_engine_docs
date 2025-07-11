
# Importing translations

## Games and internationalization

The world is full of different languages and cultures, so nowadays games
are released in several languages. To handle this, internationalized text
must be supported in any modern game engine.

In regular desktop or mobile applications, internationalized text is
usually located in resource files (or .po files for GNU stuff). Games,
however, can use several orders of magnitude more text than
applications, so they must support efficient methods for dealing with
loads of multilingual text.

There are two approaches to generate multilingual language games and
applications. Both are based on a key:value system. The first is to use
one of the languages as the key (usually English), the second is to use a
specific identifier. The first approach is probably easier for
development if a game is released first in English, later in other
languages, but a complete nightmare if working with many languages at
the same time.

In general, games use the second approach and a unique ID is used for
each string. This allows you to revise the text while it is being
translated to other languages. The unique ID can be a number, a string,
or a string with a number (it's just a unique string anyway).

Note: If you need a more powerful file format, Pandemonium also supports
loading translations written in the gettext `.po` format.

## Translation format

To complete the picture and allow efficient support for translations,
Pandemonium has a special importer that can read CSV files. Most spreadsheet
editors can export to this format, so the only requirement is that the files
have a special arrangement. The CSV files **must** be saved with UTF-8 encoding
without a [byte order mark](https://en.wikipedia.org/wiki/Byte_order_mark).

Warning: The editor does now import .csv files dropped into the project bgy default,
as these files are useful for other things aswell. If you want to use a `.csv` file
as a translation, change it's inport type from `None` to `CSV Translation`.

Warning: By default, Microsoft Excel will always save CSV files with ANSI encoding
rather than UTF-8. There is no built-in way to do this, but there are
workarounds as described
[here](https://stackoverflow.com/questions/4221176/excel-to-csv-with-utf8-encoding).

We recommend using [LibreOffice](https://www.libreoffice.org/) or Google Sheets instead.

CSV files must be formatted as follows:


| keys   | <lang1>  | <lang2>  | <langN>  |
|--------|----------|----------|----------|
| KEY1   | string   | string   | string   |
| KEY2   | string   | string   | string   |
| KEYN   | string   | string   | string   |


The "lang" tags must represent a language, which must be one of the valid
locales supported by the engine. The "KEY" tags must be
unique and represent a string universally (they are usually in
uppercase, to differentiate from other strings). These keys will be replaced at
runtime by the matching translated string. Note that the case is important,
"KEY1" and "Key1" will be different keys.
The top-left cell is ignored and can be left empty or having any content.
Here's an example:


| keys  | en                    | es                     | ja                           |
|-------|-----------------------|------------------------|------------------------------|
| GREET | Hello, friend!        | Hola, amigo!           | こんにちは                   |
| ASK   | How are you?          | Cómo está?             | 元気ですか                   |
| BYE   | Goodbye               | Adiós                  | さようなら                   |
| QUOTE | "Hello" said the man. | "Hola" dijo el hombre. | 「こんにちは」男は言いました |


The same example is shown below as a comma-separated plain text file,
which should be the result of editing the above in a spreadsheet.
When editing the plain text version, be sure to enclose with double
quotes any message that contains commas, line breaks or double quotes,
so that commas are not parsed as delimiters, line breaks don't create new
entries and double quotes are not parsed as enclosing characters. Be sure
to escape any double quotes a message may contain by preceding them with
another double quote. Alternatively, you can select another delimiter than
comma in the import options.

```
keys,en,es,ja
GREET,"Hello, friend!","Hola, amigo!",こんにちは
ASK,How are you?,Cómo está?,元気ですか
BYE,Goodbye,Adiós,さようなら
QUOTE,"""Hello"" said the man.","""Hola"" dijo el hombre.",「こんにちは」男は言いました
```

## CSV importer

Unlike Godot, Pandemonium will not treat CSV files as translations by default!

Importing will also add the translation to the list of
translations to load when the game runs, specified in project.pandemonium (or the
project settings). Pandemonium allows loading and removing translations at
runtime as well.

Select the `.csv` file and access the **Import** dock to define import
options. You can toggle the compression of the imported translations, and
select the delimiter to use when parsing the CSV file.

![](img/import_csv.png)

Be sure to click **Reimport** after any change to these options.

