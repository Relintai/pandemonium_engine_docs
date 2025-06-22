
# CLion

[CLion](https://www.jetbrains.com/clion/) is a commercial [JetBrains](https://www.jetbrains.com/) IDE for C++.

## Importing the project

CLion requires a `CMakeLists.txt` file as a project file, which is problematic
for Pandemonium because it uses the SCons buildsystem instead of CMake. However,
there is a `CMakeLists.txt` configuration for Android Studio`
which can also be used by CLion.

- From the CLion's welcome window choose the option to import an existing
  project. If you've already opened another project, choose **File > Open**
  from the top menu.
- Navigate to `<Pandemonium root directory>/platform/android/java/nativeSrcsConfigs` (the
  `CMakeLists.txt` file is located there) and select it (but *not* the
  `CMakeLists.txt` file itself), then click **OK**.

![](img/clion_1_open.png)

The folder containing the `CMakeLists.txt` file.

- If this popup window appears, select **This Window** to open the project:

![](img/clion_2_this_window.png)

- Choose **Tools &gt; CMake &gt; Change Project Root** from the top menu and select
  the Pandemonium root folder.

![](img/clion_3_change_project_root.png)

- You should be now be able to see all the project files. Autocomplete should
  work once the project has finished indexing.

## Debugging the project

Since CLion does not support SCons, you won't be able to compile, launch, and debug Pandemonium from CLion in one step.
You will first need to compile pandemonium yourself
and run the binary without CLion. You will then be able to debug Pandemonium by using the
[Attach to process](https://www.jetbrains.com/help/clion/attaching-to-local-process.html) feature.

- Run the compilation in debug mode by entering `scons`.

- Run the binary you have created (in the bin directory). If you want to debug a specific
  project, run the binary with the following arguments : `--editor --path path/to/your/pandemonium/project`. To
  run the project instead of editing it, remove the `--editor` argument.

- In CLion, go to **Run &gt; Attach to Process...**

![](img/clion_4_select_attach_to_process.png)

- Find and Select pandemonium in the list (or type the binary name/Process ID)

![](img/clion_5_select_pandemonium_process.png)

You can now use the debugging tools from CLion.

Note:

    If you run the binary without any arguments, you will only debug the project manager window.
    Don't forget to add the `--path path/to/your/pandemonium/project` argument to debug a project.

