
# Compiling for macOS

This page describes how to compile macOS editor and export template binaries from source. If you're looking to 
export your project to macOS instead, read `doc_exporting_for_macos`.

## Requirements

For compiling under macOS, the following is required:

- `Python 3.5+ ( https://www.python.org )`.
- `SCons 3.0+ ( https://www.scons.org )` build system.
- `Xcode ( https://apps.apple.com/us/app/xcode/id497799835 )`
  (or the more lightweight Command Line Tools for Xcode).
- *Optional* - `yasm ( https://yasm.tortall.net/ )` (for WebM SIMD optimizations).

### Note:

If you have `Homebrew ( https://brew.sh/ )` installed, you can easily install SCons and yasm using the following command:

```
brew install scons yasm
```

Installing Homebrew will also fetch the Command Line Tools for Xcode automatically if you don't have them already.

Similarly, if you have `MacPorts ( https://www.macports.org/ )` installed, you can easily install 
SCons and yasm using the following command:

```
sudo port install scons yasm
```

To get the Pandemonium source code for compiling, see `doc_getting_source`.

For a general overview of SCons usage for Pandemonium, see `doc_introduction_to_the_buildsystem`.

## Compiling

Start a terminal, go to the root directory of the engine source code.

To compile for Intel (x86-64) powered Macs, use

```
scons platform=osx arch=x86_64 --jobs=$(sysctl -n hw.logicalcpu)
```

To compile for Apple Silicon (ARM64) powered Macs, use:

```
scons platform=osx arch=arm64 --jobs=$(sysctl -n hw.logicalcpu)
```

To support both architectures in a single "Universal 2" binary, run the above two commands and then use `lipo` to bundle them together:

```
lipo -create bin/pandemonium.osx.tools.x86_64 bin/pandemonium.osx.tools.arm64 -output bin/pandemonium.osx.tools.universal
```

If all goes well, the resulting binary executable will be placed in the `bin/` subdirectory. This executable 
file contains the whole engine and runs without any dependencies. Executing it will bring up the project manager.

If you want to use separate editor settings for your own Pandemonium builds and official releases, you can enable 
`doc_data_paths_self_contained_mode` by creating a file called `._sc_` or `sc_` in the `bin/` folder.

To create an `.app` bundle like in the official builds, you need to use the
template located in `misc/dist/osx_tools.app`. Typically, for an optimized
editor binary built with `target=release_debug`:

```
cp -r misc/dist/osx_tools.app ./Pandemonium.app
mkdir -p Pandemonium.app/Contents/MacOS
cp bin/pandemonium.osx.opt.tools.universal Pandemonium.app/Contents/MacOS/Pandemonium
chmod +x Pandemonium.app/Contents/MacOS/Pandemonium
```

## Compiling a headless/server build

To compile a *headless* build which provides editor functionality to export
projects in an automated manner, use:

```
scons platform=server tools=yes target=release_debug --jobs=$(sysctl -n hw.logicalcpu)
```

To compile a debug *server* build which can be used with
`remote debugging tools ( doc_command_line_tutorial )`, use:

```
scons platform=server tools=no target=release_debug --jobs=$(sysctl -n hw.logicalcpu)
```

To compile a release *server* build which is optimized to run dedicated game servers,
use:

```
scons platform=server tools=no target=release --jobs=$(sysctl -n hw.logicalcpu)
```

## Building export templates

To build macOS export templates, you have to compile with `tools=no` (no
editor) and respectively for `target=release` (release template) and
`target=release_debug`.

Official templates are universal binaries which support both Intel x86_64 and
ARM64 architectures. You can also create export templates that support only one
of those two architectures by leaving out the `lipo` step below.

- For Intel x86_64:

```
scons platform=osx tools=no target=release arch=x86_64 --jobs=$(sysctl -n hw.logicalcpu)
scons platform=osx tools=no target=release_debug arch=x86_64 --jobs=$(sysctl -n hw.logicalcpu)
```

- For ARM64 (Apple M1):

```
scons platform=osx tools=no target=release arch=arm64 --jobs=$(sysctl -n hw.logicalcpu)
scons platform=osx tools=no target=release_debug arch=arm64 --jobs=$(sysctl -n hw.logicalcpu)
```

To support both architectures in a single "Universal 2" binary, run the above
two commands blocks and then use `lipo` to bundle them together:

```
lipo -create bin/pandemonium.osx.opt.x86_64 bin/pandemonium.osx.opt.arm64 -output bin/pandemonium.osx.opt.universal
lipo -create bin/pandemonium.osx.opt.debug.x86_64 bin/pandemonium.osx.opt.debug.arm64 -output bin/pandemonium.osx.opt.debug.universal
```

To create an `.app` bundle like in the official builds, you need to use the
template located in `misc/dist/osx_template.app`. The release and debug
builds should be placed in `osx_template.app/Contents/MacOS` with the names
`pandemonium_osx_release.64` and `pandemonium_osx_debug.64` respectively. You can do so
with the following commands (assuming a universal build, otherwise replace the
`.universal` extension with the one of your arch-specific binaries):

```
cp -r misc/dist/osx_template.app .
mkdir -p osx_template.app/Contents/MacOS
cp bin/pandemonium.osx.opt.universal osx_template.app/Contents/MacOS/pandemonium_osx_release.64
cp bin/pandemonium.osx.opt.debug.universal osx_template.app/Contents/MacOS/pandemonium_osx_debug.64
chmod +x osx_template.app/Contents/MacOS/pandemonium_osx*
```

You can then zip the `osx_template.app` folder to reproduce the `osx.zip`
template from the official Pandemonium distribution:

```
zip -q -9 -r osx.zip osx_template.app
```

## Cross-compiling for macOS from Linux

It is possible to compile for macOS in a Linux environment (and maybe also in
Windows using the Windows Subsystem for Linux). For that, you'll need to install
`OSXCross ( https://github.com/tpoechtrager/osxcross )` to be able to use macOS
as a target. First, follow the instructions to install it:

Clone the `OSXCross repository ( https://github.com/tpoechtrager/osxcross )`
somewhere on your machine (or download a ZIP file and extract it somewhere),
e.g.:

```
git clone --depth=1 https://github.com/tpoechtrager/osxcross.git "$HOME/osxcross"
```

1. Follow the instructions to package the SDK:
   https://github.com/tpoechtrager/osxcross#packaging-the-sdk
2. Follow the instructions to install OSXCross:
   https://github.com/tpoechtrager/osxcross#installation

After that, you will need to define the `OSXCROSS_ROOT` as the path to
the OSXCross installation (the same place where you cloned the
repository/extracted the zip), e.g.:

```
export OSXCROSS_ROOT="$HOME/osxcross"
```

Now you can compile with SCons like you normally would:

```
scons platform=osx
```

If you have an OSXCross SDK version different from the one expected by the SCons buildsystem, you can specify a custom one with the `osxcross_sdk` argument:

```
scons platform=osx osxcross_sdk=darwin15
```