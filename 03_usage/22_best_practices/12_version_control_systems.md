
# Version Control Systems

## Introduction

Pandemonium aims to be VCS friendly and generate mostly readable and mergeable files.

## Files to exclude from VCS

There are some folders Pandemonium creates you should have your VCS ignore:

- `.import/`: This folder stores all the files it imports automatically based on
  your source assets and their import flags.
- `*.translation`: These files are binary imported translations generated from CSV files.
- `export_presets.cfg`: This file contains all the export presets for the
  project, including sensitive information such as Android keystore credentials.
- `.mono/`: This folder stores automatically-generated Mono files. It only exists
  in projects that use the Mono version of Pandemonium.

## Working with Git on Windows

Most Git for Windows clients are configured with the `core.autocrlf` set to `true`.
This can lead to files unnecessarily being marked as modified by Git due to their line endings being converted automatically.
It is better to set this option as:

```
git config --global core.autocrlf input
```

