.. _doc_godot_notifications:

Godot notifications
===================

Every Object in Godot implements a
`_notification` method. Its purpose is to
allow the Object to respond to a variety of engine-level callbacks that may
relate to it. For example, if the engine tells a
`CanvasItem` to "draw", it will call
``_notification(NOTIFICATION_DRAW)``.

Some of these notifications, like draw, are useful to override in scripts. So
much so that Godot exposes many of them with dedicated functions:

- ``_ready()`` : NOTIFICATION_READY

- ``_enter_tree()`` : NOTIFICATION_ENTER_TREE

- ``_exit_tree()`` : NOTIFICATION_EXIT_TREE

- ``_process(delta)`` : NOTIFICATION_PROCESS

- ``_physics_process(delta)`` : NOTIFICATION_PHYSICS_PROCESS

- ``_draw()`` : NOTIFICATION_DRAW

What users might *not* realize is that notifications exist for types other
than Node alone:

- `Object::NOTIFICATION_POSTINITIALIZE`:
  a callback that triggers during object initialization. Not accessible to scripts.

- `Object::NOTIFICATION_PREDELETE`:
  a callback that triggers before the engine deletes an Object, i.e. a
  'destructor'.

- `MainLoop::NOTIFICATION_WM_MOUSE_ENTER`:
  a callback that triggers when the mouse enters the window in the operating
  system that displays the game content.

And many of the callbacks that *do* exist in Nodes don't have any dedicated
methods, but are still quite useful.

- `Node::NOTIFICATION_PARENTED`:
  a callback that triggers anytime one adds a child node to another node.

- `Node::NOTIFICATION_UNPARENTED`:
  a callback that triggers anytime one removes a child node from another
  node.

- `Popup::NOTIFICATION_POST_POPUP`:
  a callback that triggers after a Popup node completes any ``popup*`` method.
  Note the difference from its ``about_to_show`` signal which triggers
  *before* its appearance.

One can access all these custom notifications from the universal
``_notification`` method.

.. note::
  Methods in the documentation labeled as "virtual" are also intended to be
  overridden by scripts.

  A classic example is the
  `_init` method in Object. While it has no
  ``NOTIFICATION_*`` equivalent, the engine still calls the method. Most languages
  (except C#) rely on it as a constructor.

So, in which situation should one use each of these notifications or
virtual functions?

_process vs. _physics_process vs. \*_input
------------------------------------------

Use ``_process`` when one needs a framerate-dependent deltatime between
frames. If code that updates object data needs to update as often as
possible, this is the right place. Recurring logic checks and data caching
often execute here, but it comes down to the frequency at which one needs
the evaluations to update. If they don't need to execute every frame, then
implementing a Timer-yield-timeout loop is another option.

gdscript GDScript

```
    # Infinitely loop, but only execute whenever the Timer fires.
    # Allows for recurring operations that don't trigger script logic
    # every frame (or even every fixed frame).
    while true:
        my_method()
        $Timer.start()
        yield($Timer, "timeout")
```

Use ``_physics_process`` when one needs a framerate-independent deltatime
between frames. If code needs consistent updates over time, regardless
of how fast or slow time advances, this is the right place.
Recurring kinematic and object transform operations should execute here.

While it is possible, to achieve the best performance, one should avoid
making input checks during these callbacks. ``_process`` and
``_physics_process`` will trigger at every opportunity (they do not "rest" by
default). In contrast, ``*_input`` callbacks will trigger only on frames in
which the engine has actually detected the input.

One can check for input actions within the input callbacks just the same.
If one wants to use delta time, one can fetch it from the related
deltatime methods as needed.

gdscript GDScript

```
    # Called every frame, even when the engine detects no input.
    func _process(delta):
        if Input.is_action_just_pressed("ui_select"):
            print(delta)

    # Called during every input event.
    func _unhandled_input(event):
        match event.get_class():
            "InputEventKey":
                if Input.is_action_just_pressed("ui_accept"):
                    print(get_process_delta_time())
```


_init vs. initialization vs. export
-----------------------------------

If the script initializes its own node subtree, without a scene,
that code should execute here. Other property or SceneTree-independent
initializations should also run here. This triggers before ``_ready`` or
``_enter_tree``, but after a script creates and initializes its properties.

Scripts have three types of property assignments that can occur during
instantiation:

gdscript GDScript

```
    # "one" is an "initialized value". These DO NOT trigger the setter.
    # If someone set the value as "two" from the Inspector, this would be an
    # "exported value". These DO trigger the setter.
    export(String) var test = "one" setget set_test

    func _init():
        # "three" is an "init assignment value".
        # These DO NOT trigger the setter, but...
        test = "three"
        # These DO trigger the setter. Note the `self` prefix.
        self.test = "three"

    func set_test(value):
        test = value
        print("Setting: ", test)
```


When instantiating a scene, property values will set up according to the
following sequence:

1. **Initial value assignment:** instantiation will assign either the
   initialization value or the init assignment value. Init assignments take
   priority over initialization values.

2. **Exported value assignment:** If instancing from a scene rather than
   a script, Godot will assign the exported value to replace the initial
   value defined in the script.

As a result, instantiating a script versus a scene will affect both the
initialization *and* the number of times the engine calls the setter.

_ready vs. _enter_tree vs. NOTIFICATION_PARENTED
------------------------------------------------

When instantiating a scene connected to the first executed scene, Godot will
instantiate nodes down the tree (making ``_init`` calls) and build the tree
going downwards from the root. This causes ``_enter_tree`` calls to cascade
down the tree. Once the tree is complete, leaf nodes call ``_ready``. A node
will call this method once all child nodes have finished calling theirs. This
then causes a reverse cascade going up back to the tree's root.

When instantiating a script or a standalone scene, nodes are not
added to the SceneTree upon creation, so no ``_enter_tree`` callbacks
trigger. Instead, only the ``_init`` call occurs. When the scene is added
to the SceneTree, the ``_enter_tree`` and ``_ready`` calls occur.

If one needs to trigger behavior that occurs as nodes parent to another,
regardless of whether it occurs as part of the main/active scene or not, one
can use the `PARENTED` notification.
For example, here is a snippet that connects a node's method to
a custom signal on the parent node without failing. Useful on data-centric
nodes that one might create at runtime.

gdscript GDScript

```
    extends Node

    var parent_cache

    func connection_check():
        return parent.has_user_signal("interacted_with")

    func _notification(what):
        match what:
            NOTIFICATION_PARENTED:
                parent_cache = get_parent()
                if connection_check():
                    parent_cache.connect("interacted_with", self, "_on_parent_interacted_with")
            NOTIFICATION_UNPARENTED:
                if connection_check():
                    parent_cache.disconnect("interacted_with", self, "_on_parent_interacted_with")

    func _on_parent_interacted_with():
        print("I'm reacting to my parent's interaction!")
```
