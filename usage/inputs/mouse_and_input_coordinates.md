

Mouse and input coordinates
===========================

About
-----

The reason for this small tutorial is to clear up many common mistakes
about input coordinates, obtaining mouse position and screen resolution,
etc.

Hardware display coordinates
----------------------------

Using hardware coordinates makes sense in the case of writing complex
UIs meant to run on PC, such as editors, MMOs, tools, etc. However, it does
not make as much sense outside of that scope.

Viewport display coordinates
----------------------------

Pandemonium uses viewports to display content, and viewports can be scaled by
several options (see `doc_multiple_resolutions` tutorial). Use, then, the
functions in nodes to obtain the mouse coordinates and viewport size,
for example:

gdscript GDScript

```
    func _input(event):
       # Mouse in viewport coordinates.
       if event is InputEventMouseButton:
           print("Mouse Click/Unclick at: ", event.position)
       elif event is InputEventMouseMotion:
           print("Mouse Motion at: ", event.position)

       # Print the size of the viewport.
       print("Viewport Resolution is: ", get_viewport_rect().size)
```


Alternatively, it's possible to ask the viewport for the mouse position:

gdscript GDScript

```
    get_viewport().get_mouse_position()
```

Note:
 When the mouse mode is set to `Input.MOUSE_MODE_CAPTURED`, the `event.position` value from `InputEventMouseMotion` is the center of the screen. Use `event.relative` instead of `event.position` and `event.speed` to process mouse movement and position changes.
