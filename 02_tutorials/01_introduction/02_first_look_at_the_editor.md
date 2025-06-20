
# First look at Pandemonium's editor

This page will give you a brief overview of Pandemonium's interface. We're going to
look at the different main screens and docks to help you situate yourself.

For a comprehensive breakdown of the editor's interface and how to
use it, see the [Editor manual](../../03_usage/18_editor/).

## The Project manager

When you launch Pandemonium, the first window you see is the Project Manager. In the
default tab, "Projects," you can manage existing projects, import or create new
ones, and more.

![](img/editor_intro_project_manager.png)

At the top of the window, there is another tab named "Asset Library Projects".
In the open-source asset library you can search for demo projects, templates,
and completed projects, including many that are developed by the community.

![](img/editor_intro_project_templates.png)

You can also change the editor's language using the drop-down menu to the right
of the engine's version in the window's top-right corner. By default, it is in
English (EN).

![](img/editor_intro_language.png)

## First look at Pandemonium's editor

When you open a new or an existing project, the editor's interface appears.
Let's look at its main areas.

![](img/editor_intro_editor_empty.png)

By default, it features **menus**, **main screens**, and playtest buttons along
the window's top edge.

![](img/editor_intro_top_menus.png)

In the center is the **viewport** with its **toolbar** at the top, where you'll
find tools to move, scale, or lock the scene's nodes.

![](img/editor_intro_3d_viewport.png)

On either side of the viewport sit the **docks**. And at the bottom of the
window lies the **bottom panel**.

The toolbar changes based on the context and selected node. Here is the 2D toolbar.

![](img/editor_intro_toolbar_2d.png)

Below is the 3D one.

![](img/editor_intro_toolbar_3d.png)

Let's look at the docks. The **FileSystem** dock lists your project files, be it
scripts, images, audio samples, and more.

![](img/editor_intro_filesystem_dock.png)

The **Scene** dock lists the active scene's nodes.

![](img/editor_intro_scene_dock.png)

The **Inspector** allows you to edit the properties of a selected node.

![](img/editor_intro_inspector_dock.png)

The **bottom panel**, situated below the viewport, is the host for the debug
console, the animation editor, the audio mixer, and more. They can take precious
space, that's why they're folded by default.

![](img/editor_intro_bottom_panels.png)

When you click on one, it expands vertically. Below, you can see the animation editor opened.

![](img/editor_intro_bottom_panel_animation.png)

## The four main screens

There are four main screen buttons centered at the top of the editor:
2D, 3D, Script, and AssetLib.

You'll use the **2D screen** for all types of games. In addition to 2D games,
the 2D screen is where you'll build your interfaces.

![](img/editor_intro_workspace_2d.png)

In the **3D screen**, you can work with meshes, lights, and design levels for
3D games.

![](img/editor_intro_workspace_3d.png)

Notice the perspective button under the toolbar. Clicking on it opens a list of
options related to the 3D view.

![](img/editor_intro_3d_viewport_perspective.png)

Note: Read [Introduction to 3d](../../03_usage/03_3d/01_introduction_to_3d.md) for more detail about the **3D main screen**.

The **Script screen** is a complete code editor with a debugger, rich
auto-completion, and built-in code reference.

![](img/editor_intro_workspace_script.png)


Finally there is a text editor screen, which is an editor for changing text files.

## Integrated class reference

Pandemonium comes with a built-in class reference.

You can search for information about a class, method, property, constant, or
signal by any one of the following methods:

* Pressing `F1` (or `Alt + Space` on macOS) anywhere in the editor.
* Clicking the "Search Help" button in the top-right of the Script main screen.
* Clicking on the Help menu and Search Help.
* Clicking while pressing the `Ctrl` key on a class name, function name,
  or built-in variable in the script editor.

![](img/editor_intro_search_help_button.png)

When you do any of these, a window pops up. Type to search for any item. You can
also use it to browse available objects and methods.

![](img/editor_intro_search_help.png)

Double-click on an item to open the corresponding page in the script main screen.

![](img/editor_intro_help_class_animated_sprite.png)

