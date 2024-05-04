
# Command line tutorial


Some developers like using the command line extensively. Pandemonium is
designed to be friendly to them, so here are the steps for working
entirely from the command line. Given the engine relies on almost no
external libraries, initialization times are pretty fast, making it
suitable for this workflow.

Note:

    On Windows and Linux, you can run a Pandemonium binary in a terminal by specifying
    its relative or absolute path.

    On macOS, the process is different due to Pandemonium being contained within an
    `.app` bundle (which is a *folder*, not a file). To run a Pandemonium binary
    from a terminal on macOS, you have to `cd` to the folder where the Pandemonium
    application bundle is located, then run `Pandemonium.app/Contents/MacOS/Pandemonium`
    followed by any command line arguments. If you've renamed the application
    bundle from `Pandemonium` to another name, make sure to edit this command line
    accordingly.

## Command line reference

**General options**


| Command                    | Description                                                          |
|----------------------------|----------------------------------------------------------------------|
| `-h`, `--help`, `/?`       | Display the list of command line options.                            |
| `--version`                | Display the version string.                                          |
| `-v`, `--verbose`          | Use verbose stdout mode.                                             |
| `--quiet`                  | Quiet mode, silences stdout messages. Errors are still displayed.    |


**Run options**

| Command                                          | Description                                                                                         |
|--------------------------------------------------|-----------------------------------------------------------------------------------------------------|
| `-e`, `--editor`                                 | Start the editor instead of running the scene                                                       |
|                                                  | (`tools ( doc_introduction_to_the_buildsystem_tools )` must be enabled).                            |
| `-p`, `--project-manager`                        | Start the project manager, even if a project is auto-detected                                       |
|                                                  | (`tools ( doc_introduction_to_the_buildsystem_tools )` must be enabled).                            |
| `-q`, `--quit`                                   | Quit after the first teration.                                                                      |
| `-l &lt;locale&gt;`, `--language &lt;locale&gt;` | Use a specific locale (&lt;locale&gt; being a two-letter code). See `doc_locales` for more details. |
| `--path &lt;directory&gt;`                       | Path to a project (&lt;directory&gt; must contain a 'project.pandemonium' file).                    |
| `-u`, `--upwards`                                | Scan folders upwards for 'project.pandemonium' file.                                                |
| `--main-pack &lt;file&gt;`                       | Path to a pack (.pck) file to load.                                                                 |
| `--render-thread &lt;mode&gt;`                   | Render thread mode ('unsafe', 'safe', 'separate'). See `Thread Model` for more details.             |
| `--remote-fs &lt;address&gt;`                    | Remote filesystem (`&lt;host/IP&gt;[:&lt;port&gt;]` address).                                       |
| `--audio-driver &lt;driver&gt;`                  | Audio driver. Use `--help` first to display the list of available drivers.                          |
| `--video-driver &lt;driver&gt;`                  | Video driver. Use `--help` first to display the list of available drivers.                          |

**Display options**


| Command                         | Description                                                                |
|---------------------------------|----------------------------------------------------------------------------|
| `-f`, `--fullscreen`            | Request fullscreen mode.                                                   |
| `-m`, `--maximized`             | Request a maximized window.                                                |
| `-w`, `--windowed`              | Request windowed mode.                                                     |
| `-t`, `--always-on-top`         | Request an always-on-top window.                                           |
| `--resolution &lt;W>x&lt;H&gt;` | Request window resolution.                                                 |
| `--position &lt;X>,&lt;Y&gt;`   | Request window position.                                                   |
| `--low-dpi`                     | Force low-DPI mode (macOS and Windows only).                               |
| `--no-window`                   | Run with invisible window. Useful together with `--script`.                |


**Debug options**

Note:

    Debug options are only available in the editor and debug export templates
    (they require `debug` or `release_debug` build targets, see
    `doc_introduction_to_the_buildsystem_target` for more details).


| Command                          | Description                                                                                 |
|----------------------------------|---------------------------------------------------------------------------------------------|
| `-d`, `--debug`                  | Debug (local stdout debugger).                                                              |
| `-b`, `--breakpoints`            | Breakpoint list as source::line comma-separated pairs, no spaces (use %%20 instead).        |
| `--profiling`                    | Enable profiling in the script debugger.                                                    |
| `--remote-debug &lt;address&gt;` | Remote debug (`&lt;host/IP>:&lt;port&gt;` address).                                         |
| `--debug-collisions`             | Show collision shapes when running the scene.                                               |
| `--debug-navigation`             | Show navigation polygons when running the scene.                                            |
| `--frame-delay &lt;ms&gt;`       | Simulate high CPU load (delay each frame by &lt;ms> milliseconds).                          |
| `--time-scale &lt;scale&gt;`     | Force time scale (higher values are faster, 1.0 is normal speed).                           |
| `--disable-render-loop`          | Disable render loop so rendering only occurs when called explicitly from script.            |
| `--disable-crash-handler`        | Disable crash handler when supported by the platform code.                                  |
| `--fixed-fps &lt;fps&gt;`        | Force a fixed number of frames per second. This setting disables real-time synchronization. |
| `--print-fps`                    | Print the frames per second to the stdout.                                                  |


**Standalone tools**


| Command                                        | Description                                                                                                                                   |
|------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| `-s &lt;script&gt;`, `--script &lt;script&gt;` | Run a script.                                                                                                                                 |
| `--check-only`                                 | Only parse for errors and quit (use with `--script`).                                                                                         |
| `--export &lt;target&gt;`                      | Export the project using the given export target. Export only main pack if path                                                               |
|                                                | ends with .pck or .zip (`tools ( doc_introduction_to_the_buildsystem_tools )` must be enabled).                                               |
| `--export-debug &lt;target&gt;`                | Like `--export`, but use debug template (`tools ( doc_introduction_to_the_buildsystem_tools )` must be enabled).                              |
| `--doctool &lt;path&gt;`                       | Dump the engine API reference to the given &lt;path> in XML format, merging if existing files are                                             |
|                                                | found (`tools ( doc_introduction_to_the_buildsystem_tools )` must be enabled).                                                                |
| `--no-docbase`                                 | Disallow dumping the base types (used with `--doctool`, `tools ( doc_introduction_to_the_buildsystem_tools )` must be enabled).               |
| `--build-solutions`                            | Build the scripting solutions (e.g. for C# projects, `tools ( doc_introduction_to_the_buildsystem_tools )` must be enabled).                  |
| `--gdnative-generate-json-api`                 | Generate JSON dump of the Pandemonium API for GDNative bindings (`tools ( doc_introduction_to_the_buildsystem_tools )` must be enabled).      |
| `--test &lt;test&gt;`                          | Run a unit test. Use `--help` first to display the list of tests. (`tools ( doc_introduction_to_the_buildsystem_tools )` must be enabled).    |
| `--export-pack &lt;preset> &lt;path&gt;`       | Like `--export`, but only export the game pack for the given preset. The &lt;path> extension                                                  |
|                                                | determines whether it will be in PCK or ZIP format.                                                                                           |
|                                                | (`tools ( doc_introduction_to_the_buildsystem_tools )` must be enabled).                                                                      |

## Path

It is recommended that your Pandemonium binary be in your PATH environment
variable, so it can be executed easily from any place by typing
`pandemonium`. You can do so on Linux by placing the Pandemonium binary in
`/usr/local/bin` and making sure it is called `pandemonium`.

## Setting the project path

Depending on where your Pandemonium binary is located and what your current
working directory is, you may need to set the path to your project
for any of the following commands to work correctly.

This can be done by giving the path to the `project.pandemonium` file
of your project as either the first argument, like this:

```
pandemonium path_to_your_project/project.pandemonium [other] [commands] [and] [args]
```

Or by using the `--path` argument:

```
pandemonium --path path_to_your_project [other] [commands] [and] [args]
```

For example, the full command for exporting your game (as explained below) might look like this:

```
pandemonium --path path_to_your_project --export my_export_preset_name game.exe
```

## Creating a project

Creating a project from the command line can be done by navigating the
shell to the desired place and making a project.pandemonium file.


```
mkdir newgame
cd newgame
touch project.pandemonium
```


The project can now be opened with Pandemonium.

## Running the editor

Running the editor is done by executing Pandemonium with the `-e` flag. This
must be done from within the project directory or a subdirectory,
otherwise the command is ignored and the project manager appears.

```
pandemonium -e
```

If a scene has been created and saved, it can be edited later by running
the same code with that scene as argument.

```
pandemonium -e scene.tscn
```

## Erasing a scene

Pandemonium is friends with your filesystem and will not create extra
metadata files. Use `rm` to erase a scene file. Make sure nothing
references that scene or else an error will be thrown upon opening.

```
rm scene.tscn
```

## Running the game

To run the game, simply execute Pandemonium within the project directory or
subdirectory.

```
pandemonium
```

When a specific scene needs to be tested, pass that scene to the command
line.

```
pandemonium scene.tscn
```

## Debugging

Catching errors in the command line can be a difficult task because they
just fly by. For this, a command line debugger is provided by adding
`-d`. It works for running either the game or a simple scene.

```
pandemonium -d
```

```
pandemonium -d scene.tscn
```


## Exporting

Exporting the project from the command line is also supported. This is
especially useful for continuous integration setups. The version of Pandemonium
that is headless (server build, no video) is ideal for this.

```
pandemonium --export "Linux/X11" /var/builds/project
pandemonium --export Android /var/builds/project.apk
```

The preset name must match the name of an export preset defined in the
project's `export_presets.cfg` file. If the preset name contains spaces or
special characters (such as "Windows Desktop"), it must be surrounded with quotes.

To export a debug version of the game, use the `--export-debug` switch
instead of `--export`. Their parameters and usage are the same.

To export only a PCK file, use the `--export-pack` option followed by the
preset name and output path, with the file extension, instead of `--export`.
The output path extension determines the package's format, either PCK or ZIP.

Warning:

    When specifying a relative path as the path for `--export`, `--export-debug`
    or `--export-pack`, the path will be relative to the directory containing
    the `project.pandemonium` file, **not** relative to the current working directory.

## Running a script

It is possible to run a simple `.gd` script from the command line.
This feature is especially useful in large projects, e.g. for batch
conversion of assets or custom import/export.

The script must inherit from `SceneTree` or `MainLoop`.

Here is a simple `sayhello.gd` example of how it works:

```
#!/usr/bin/env -S pandemonium -s
extends SceneTree

func _init():
    print("Hello!")
    quit()
```

And how to run it:

```
# Prints "Hello!" to standard output.
pandemonium -s sayhello.gd
```

If no `project.pandemonium` exists at the path, current path is assumed to be the
current working directory (unless `--path` is specified).

The first line of `sayhello.gd` above is commonly referred to as
a *shebang*. If the Pandemonium binary is in your `PATH` as `pandemonium`,
it allows you to run the script as follows in modern Linux
distributions, as well as macOS:

```
# Mark script as executable.
chmod +x sayhello.gd
# Prints "Hello!" to standard output.
./sayhello.gd
```

If the above doesn't work in your current version of Linux or macOS, you can
always have the shebang run Pandemonium straight from where it is located as follows:

```
#!/usr/bin/pandemonium -s
```
