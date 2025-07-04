
# When to use scenes versus scripts

We've already covered how scenes and scripts are different. Scripts
define an engine class extension with imperative code, scenes with
declarative code.

Each system's capabilities are different as a result.
Scenes can define how an extended class initializes, but not what its
behavior actually is. Scenes are often used in conjunction with a script so
that the scene acts as an extension of the scripts declarative code.

## Anonymous types

It *is* possible to completely define a scenes' contents using a script alone.
This is, in essence, what the Pandemonium Editor does, only in the C++ constructor
of its objects.

But, choosing which one to use can be a dilemma. Creating script instances
is identical to creating in-engine classes whereas handling scenes requires
a change in API:

```
const MyNode = preload("my_node.gd")
const MyScene = preload("my_scene.tscn")
var node = Node.new()
var my_node = MyNode.new() # Same method call
var my_scene = MyScene.instance() # Different method call
var my_inherited_scene = MyScene.instance(PackedScene.GEN_EDIT_STATE_MAIN) # Create scene inheriting from MyScene
```

Also, scripts will operate a little slower than scenes due to the
speed differences between engine and script code. The larger and more complex
the node, the more reason there is to build it as a scene.

## Named types

In some cases, a user can register a script as a new type within the editor
itself. This displays it as a new type in the node or resource creation dialog
with an optional icon. In these cases, the user's ability to use the script
is much more streamlined. Rather than having to...

1. Know the base type of the script they would like to use.
2. Create an instance of that base type.
3. Add the script to the node.
   1. (Drag-n-drop method)
      1. Find the script in the FileSystem dock.
      2. Drag and drop the script onto the node in the Scene dock.
   2. (Property method)
      1. Scroll down to the bottom of the Inspector to find the `script` property and select it.
      2. Select "Load" from the dropdown.
      3. Select the script from the file dialog.

With a registered script, the scripted type instead becomes a creation option
like the other nodes and resources in the system. One need not do any of the
above work. The creation dialog even has a search bar to look up the type by
name.

There are two systems for registering types...

- Custom Types
   - Editor-only. Typenames are not accessible at runtime.
   - Does not support inherited custom types.
   - An initializer tool. Creates the node with the script. Nothing more.
   - Editor has no type-awareness of the script or its relationship
     to other engine types or scripts.
   - Allows users to define an icon.
   - Works for all scripting languages because it deals with Script resources in abstract.
   - Set up using `EditorPlugin.add_custom_type`.
- Script Classes
   - Editor and runtime accessible.
   - Displays inheritance relationships in full.
   - Creates the node with the script, but can also change types
     or extend the type from the editor.
   - Editor is aware of inheritance relationships between scripts,
     script classes, and engine C++ classes.
   - Allows users to define an icon.
   - Engine developers must add support for languages manually (both name exposure and
     runtime accessibility).
   - The Editor scans project folders and registers any exposed names for all
     scripting languages. Each scripting language must implement its own
     support for exposing this information.

Both methodologies add names to the creation dialog, but script classes, in
particular, also allow for users to access the typename without loading the
script resource. Creating instances and accessing constants or static methods
is viable from anywhere.

With features like these, one may wish their type to be a script without a
scene due to the ease of use it grants users. Those developing plugins or
creating in-house tools for designers to use will find an easier time of things
this way.

On the downside, it also means having to use largely imperative programming.

## Performance of Script vs PackedScene

One last aspect to consider when choosing scenes and scripts is execution speed.

As the size of objects increases, the scripts' necessary size to create and
initialize them grows much larger. Creating node hierarchies demonstrates this.
Each Node's logic could be several hundred lines of code in length.

The code example below creates a new `Node`, changes its name, assigns a
script to it, sets its future parent as its owner so it gets saved to disk along
with it, and finally adds it as a child of the `Main` node:

```
# Main.gd
extends Node

func _init():
    var child = Node.new()
    child.name = "Child"
    child.script = preload("Child.gd")
    child.owner = self
    add_child(child)
```

Script code like this is much slower than engine-side C++ code. Each instruction
makes a call to the scripting API which leads to many "lookups" on the back-end
to find the logic to execute.

Scenes help to avoid this performance issue. `PackedScene`,
the base type that scenes inherit from, defines resources
that use serialized data to create objects. The engine can process scenes in
batches on the back-end and provide much better performance than scripts.

## Conclusion

In the end, the best approach is to consider the following:

- If one wishes to create a basic tool that is going to be re-used in several
  different projects and which people of all skill levels will likely use
  (including those who don't label themselves as "programmers"), then chances
  are that it should probably be a script, likely one with a custom name/icon.

- If one wishes to create a concept that is particular to their game, then it
  should always be a scene. Scenes are easier to track/edit and provide more
  security than scripts.

- If one would like to give a name to a scene, then they can still sort of do
  this in 3.1 by declaring a script class and giving it a scene as a constant.
  The script becomes, in effect, a namespace:

```
# game.gd
extends Reference
class_name Game # extends Reference, so it won't show up in the node creation dialog
const MyScene = preload("my_scene.tscn")

# main.gd
extends Node
func _ready():
    add_child(Game.MyScene.instance())
```

