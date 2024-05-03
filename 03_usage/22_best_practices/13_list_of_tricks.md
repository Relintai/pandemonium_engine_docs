
# Things that are not documented nor indicated anywhere

From https://github.com/godotengine/godot-docs/issues/4377

    You can hold Shift when dragging a node in Scene Tree Dock to keep local transform
    If you hold Ctrl while dragging a script file onto a node in scene tree, it will be instantiated as a new node instead of attached
    You can drag and drop nodes (1 or more) from Scene Tree into Script Editor to insert their path
        holding Ctrl will insert @onready variable
    You can drag and drop files (1 or more) from FileSystem Dock into Script Editor to insert their path
        holding Ctrl will make the file(s) preloaded
    Shift + Clicking the folding arrow in Scene Tree will fold/unfold recursively
    Same as above, but with files from FileSystem Dock
    You can drag and drop a resource from the inspector (e.g. material) to FileSystem to save it as file
    You can hold Ctrl while dragging a 2D node to quick-enable smart snapping
    You can hold Shift while dragging a 2D node to snap it to an axis
    You can drop a project file/directory into Project Manager to add it to project list
    You can press Backspace while drawing a 2D polygon to undo last point or press Enter to close the polygon
    When you hold Ctrl when moving a file in FileSystem, it will be copied instead of moved
    You can drop a file from outside onto Godot editor to copy it to the currently selected directory in FileSystem
    You can hold Ctrl when dropping texture to SpriteFrames to load it as spritesheet
    When you hold Alt while dragging timeline in Animation, the animation won't update (only time changes)
    When you hold Alt while changing RectangleShape2D, it will change symmetrically
    When you hold Shift when pressing arrows to move 2D node, the movement will be snapped to grid
    When you drag and drop node branch from Scene Tree to Filesystem, it will be saved as scene
    If you hold Shift while clicking animation timeline, your step will be divided by 4
    Alt + Mouse Wheel on animation track will move timeline cursor step by step
        Add Shift to move by 1/4 step
    when you add a meta _editor_icon to any node, the icon will be used in the editor (might get deprecated in 4.0)
    Right-click on SpinBox arrow will instantly set the value to min/max
    Renaming a node to an empty name automatically makes it have its base class' name

Things that are handy, but not documented and easy to miss

    If you disable Editor Settings/Editors/2D/Constrain Editor View, you can move freely in 2D editor
    When you double click an audio resource, an audio player will appear at the bottom of the inspector. It's especially useful to easily preview custom loop points in audio files
    Assigning a ButtonGroup to a CheckBox will change it visually to radio button
    Editor Settings/Interface/Scene Tabs/Restore Scenes On Load can be enabled to automatically open last opened scenes
    If you have 2 monitors, you can change Editor Settings/Run/Window Placement/Screen to run the project on another monitor from the editor
    In Misc tab in the debugger you can see what Control node was just clicked
    You can use Project Settings/Editor/Search In File Extensions to add more files for searching with Search In Files (e.g. you can add .tscn to search in scenes)
    If you need to quickly go to project user data directory, use Project -> Open Project Data Folder
    You can evaluate expression inside Script Editor by using Edit -> Evaluate Expression. E.g. you can write 1 + 2, select it and press Ctrl + Shift + E to turn it into 3
    When you have an empty scene, instead of picking root node you can press the star icon to select from favorite nodes
    2D Select Tool has lots of useful functionality, which is only mentioned in a long tooltip

Misc tricks

    If you want to delete nodes without confirmation, you can unbind the default 'Delete Node' shortcut and bind 'Delete (no confirm)' instead
    If you have a node at (0, 0) and want to very quickly move it to the position of another node, you can reparent it to that node while holding Shift and then reparent back with Shift released
    You can hide scrollbars of TextEdit if you set their modulate to 0 and mouse filter to ignore
    You can get a global reference to SceneTree (even from outside tree) by using Engine.get_main_loop()
    If some method requires method name (e.g. SceneTree.call_group()), you can avoid using strings by using some_func.get_method(), which returns Callable's name


Also you can shift + clic when using bitmaps in autotile to set wilcard bits, this is really helpful when your tileset doesn't need to be complete (but anyways tileMaps will be rewriten in 4.0 so it's more a enchancement for only 3.2 documentation)


Shift+Click creates a bookmark instead of a breakpoint (I implemented it but didn't figure out how to document it...)

Gradient editor these undocumented tricks:

    Ctrl+Drag snaps to a grid (1/10)
    Ctrl+Shift+Drag snaps to a finer grid (1/40)
    Shift+Drag keeps offsets away from each other
    Alt + Drag on a handle duplicates it

The curve editor also doesn't document that Ctrl snaps the points to a grid.


Last time I checked this still worked: if you confirm the change to the value of a component of a vector/matrix property in the inspector with Shift+Enter when you have multiple nodes selected, you keep the rest of the components in all nodes intact, instead of setting the whole property to the new resulting value for all the selected nodes.

E.g., selecting multiple sprites and setting all the 'x' component of their positions to the same value without affecting 'y' in any.


Regarding fields in the inspector:

    What you write in the inspector are expressions. So you can use use a constant such as PI or type operations 3*PI/2.
    You can click and drag a numeric value (without keyboard focus) to change it. If you hold CTRLit will give you integer values even if the field is float. SHIFT will give you smaller increments.
    When you are editing a numeric value (with keyboard focus), pressing up increases the value, pressing down decreases the value.
        (With CTRL) by 100.
        (With SHIFT) by 10.
        (With ALT) by 0.1.
        (With no modifier) by 1.

Dragging a script from the FileSystem to a Node in the Scene will attach/replace the script to the Node.

But!

Holding Ctrl while dragging a script from the FileSystem to a Node in the Scene will create a new Node with the script attached.

There is no indication that holding Ctrl does anything until you drop.

Renaming a node to an empty name automatically makes it have its base class' name (script class_names don't count)
