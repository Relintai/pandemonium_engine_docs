
# Running code in the editor

## What is `tool`?

`tool` is a powerful line of code that, when added at the top of your script, makes it execute
in the editor. You can also decide which parts of the script execute in the editor, which
in game, and which in both.

You can use it for doing many things, but it is mostly useful in level design for visually
presenting things that are hard to predict ourselves. Here are some use cases:

- If you have a cannon that shoots cannonballs affected by physics (gravity), you can draw the
  cannonball's trajectory in the editor, making level design a lot easier.
- If you have jumppads with varying jump heights, you can draw the maximum jump height a
  player would reach if it jumped on one, also making level design easier.
- If your player doesn't use a sprite, but draws itself using code, you can make that drawing code execute in the editor to see your player.

### DANGER:

`tool` scripts run inside the editor, and let you access the scene tree
of the currently edited scene. This is a powerful feature which also comes
with caveats, as the editor does not include protections for potential
misuse of `tool` scripts.
Be **extremely** cautious when manipulating the scene tree, especially via
`Node.queue_free()`, as it can cause
crashes if you free a node while the editor runs logic involving it.

## How to use it

To turn a script into a tool, add the keyword `tool` at the top of your code.

To check if you are currently in the editor, use: `Engine.editor_hint`.

For example, if you want to execute some code only in the editor, use:

```
if Engine.editor_hint:
    # Code to execute when in editor.
```

On the other hand, if you want to execute code only in game, simply negate the same statement:

```
if not Engine.editor_hint:
    # Code to execute when in game.
```

Pieces of code do not have either of the 2 conditions above will run both in-editor and in-game.

Here is how a `process()` function might look for you:

```
func _process(delta):
    if Engine.editor_hint:
        # Code to execute in editor.

    if not Engine.editor_hint:
        # Code to execute in game.

    # Code to execute both in editor and in game.
```

Note: Modifications in editor are permanent. For example, in the following case, when we remove
the script, the node will keep its rotation. Be careful to avoid making unwanted modifications.

## Try it out

Add a `Sprite` node to your scene and set the texture to Pandemonium icon. Attach and open a script, and change it to this:

```
tool
extends Sprite

func _process(delta):
    rotation_degrees += 180 * delta
```

Save the script and return to the editor. You should now see your object rotate. If you run the game, it will also rotate.

![](img/rotating_in_editor.gif)

Note: If you don't see the changes, reload the scene (close it and open it again).

Now let's choose which code runs when. Modify your `process()` function to look like this:

```
func _process(delta):
    if Engine.editor_hint:
        rotation_degrees += 180 * delta
    else:
        rotation_degrees -= 180 * delta
```

Save the script. Now the object will spin clockwise in the editor, but if you run the game, it will spin counter-clockwise.

## Editing variables

Add and export a variable speed to the script. The function set_speed after "setget" is executed with your input to change the variable.
Modify  `process()` to include the rotation speed.

```
tool
extends Sprite


export var speed = 1 setget set_speed


# Update speed and reset the rotation.
func set_speed(new_speed):
	speed = new_speed
	rotation_degrees = 0


func _process(delta):
	rotation_degrees += 180 * delta * speed
```


Note: Code from other nodes doesn't run in the editor. Your access to other nodes is limited. You can
access the tree and nodes, and their default properties, but you can't access user variables. If you
want to do so, other nodes have to run in the editor too. AutoLoad nodes cannot be accessed in the editor at all.

## Instancing scenes

You can instantiate packed scenes normally and add them to the scene currently
opened in the editor. By default, nodes or scenes added with
`Node.add_child(node)` are **not** visible
in the Scene tree dock and are **not** persisted to disk. If you wish the node
or scene to be visible in the scene tree dock and persisted to disk when saving
the scene, you need to set the child node's `owner`
property to the currently edited scene root.

If you are using `tool`:

```
func _ready():
    var node = Spatial.new()
    add_child(node) # Parent could be any node in the scene

    # The line below is required to make the node visible in the Scene tree dock
    # and persist changes made by the tool script to the saved scene file.
    node.set_owner(get_tree().edited_scene_root)
```

If you are using `EditorScript`:

```
func _run():
    var parent = get_scene().find_node("Parent") # Parent could be any node in the scene
    var node = Spatial.new()
    parent.add_child(node)

    # The line below is required to make the node visible in the Scene tree dock
    # and persist changes made by the tool script to the saved scene file.
    node.set_owner(get_scene())
```

Warning: Using `tool` improperly can yield many errors. It is advised to first write the
code how you want it, and only then add the `tool` keyword to the top. Also, make sure
to separate code that runs in-editor from code that runs in-game. This way, you
can find bugs more easily.

