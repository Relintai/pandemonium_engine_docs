
# Overridable functions

Pandemonium's Node class provides virtual functions you can override to update nodes
every frame or on specific events, like when they enter the scene tree.

This document presents the ones you'll use most often.

See also: Under the hood, these functions rely on Pandemonium's low-level
notifications system. To learn more about it, see
[pandemonium notifications](../22_best_practices/08_pandemonium_notifications.md).

Two functions allow you to initialize and get nodes, besides the class's
constructor: `enter_tree()` and `ready()`.

When the node enters the Scene Tree, it becomes active and the engine calls its
`enter_tree()` method. That node's children may not be part of the active scene yet. As
you can remove and re-add nodes to the scene tree, this function may be called
multiple times throughout a node's lifetime.

Most of the time, you'll use `ready()` instead. This function is called only
once in a node's lifetime, after `enter_tree()`. `ready()` ensures that all children
have entered the scene tree first, so you can safely call `get_node()` on it.

Another related callback is `exit_tree()`, which the engine calls every time
a node exits the scene tree. This can be when you call `Node.remove_child()`
or when you free a node.

```
# Called every time the node enters the scene tree.
func _enter_tree():
    pass

# Called when both the node and its children have entered the scene tree.
func _ready():
    pass

# Called when the node is about to leave the scene tree, after all its
# children received the _exit_tree() callback.
func _exit_tree():
    pass
```

The two virtual methods `process()` and `physics_process()` allow you to
update the node, every frame and every physics frame respectively.

```
# Called every frame, as often as possible.
func _process(delta):
    pass

# Called every physics frame.
func _physics_process(delta):
    pass
```

Two more essential built-in node callback functions are
`Node._unhandled_input()` and
`Node._input()`, which you use to both receive
and process individual input events. The `unhandled_input()` method receives
every key press, mouse click, etc. that have not been handled already in an
`input()` callback or in a user interface component. You want to use it for
gameplay input in general. The `input()` callback allows you to intercept and
process input events before `unhandled_input()` gets them.

```
# Called once for every event.
func _unhandled_input(event):
    pass

# Called once for every event, before _unhandled_input(), allowing you to
# consume some events.
func _input(event):
    pass
```

There are some more overridable functions like
`Node._get_configuration_warning()`. Specialized node types provide
more callbacks like `CanvasItem._draw()` to
draw programmatically or `Control._gui_input()` to handle clicks and input on UI elements.

