
# Exporting for Windows

The simplest way to distribute a game for PC is to copy the executable
(`pandemonium.exe`), compress the folder and send it to someone else. However, this
is often not desired.

Pandemonium offers a more elegant approach for PC distribution when using the export
system. When exporting for Windows, the exporter takes all the project files and
creates a `data.pck` file. This file is bundled with a specially optimized
binary that is smaller, faster and does not contain the editor and debugger.

## Requirements

- To enable code signing, you must have the `Windows 10 SDK` (on Windows) or [osslsigncode](https://github.com/mtrojnar/osslsigncode)
  (on any other OS) installed.
- Download the Pandemonium export templates. Use the Pandemonium menu: `Editor > Manage Export Templates`.

### Warning:

If you export for Windows with embedded PCK files, you will not be able to
sign the program as it will break.

On Windows, PCK embedding is also known to cause false positives in
antivirus programs. Therefore, it's recommended to avoid using it unless
you're distributing your project via Steam as it bypasses code signing and
antivirus checks.

