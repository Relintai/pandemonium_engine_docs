
# Custom GUI controls

## So many controls...

Yet there are never enough. Creating your own custom controls that act
just the way you want them to is an obsession of almost every GUI
programmer. Pandemonium provides plenty of them, but they may not work exactly
the way you want. Before contacting the developers with a pull-request
to support diagonal scrollbars, at least it will be good to know how to
create these controls easily from script.

## Drawing

For drawing, it is recommended to check the [custom drawing in 2d](../02_2d/07_custom_drawing_in_2d.md) tutorial.
The same applies. Some functions are worth mentioning due to their
usefulness when drawing, so they will be detailed next:

### Checking control size

Unlike 2D nodes, "size" is important with controls, as it helps to
organize them in proper layouts. For this, the `Control.rect_size`
property is provided. Checking it during `draw()` is vital to ensure
everything is kept in-bounds.

### Checking focus

Some controls (such as buttons or text editors) might provide input
focus for keyboard or joypad input. Examples of this are entering text
or pressing a button. This is controlled with the `Control.focus_mode`
property. When drawing, and if the control supports input focus, it is
always desired to show some sort of indicator (highlight, box, etc.) to
indicate that this is the currently focused control. To check for this
status, the `Control.has_focus()` method exists. Example

```
func _draw():
    if has_focus():
         draw_selected()
    else:
         draw_normal()
```

## Sizing

As mentioned before, size is important to controls. This allows
them to lay out properly, when set into grids, containers, or anchored.
Controls, most of the time, provide a *minimum size* to help properly
lay them out. For example, if controls are placed vertically on top of
each other using a `VBoxContainer`,
the minimum size will make sure your custom control is not squished by
the other controls in the container.

To provide this callback, just override `Control.get_minimum_size()`,
for example:

```
func get_minimum_size():
    return Vector2(30, 30)
```

Alternatively, set it using a function:

```
func _ready():
    set_custom_minimum_size(Vector2(30, 30))
```

## Input

Controls provide a few helpers to make managing input events much easier
than regular nodes.

### Input events

There are a few tutorials about input before this one, but it's worth
mentioning that controls have a special input method that only works
when:

-  The mouse pointer is over the control.
-  The button was pressed over this control (control always
   captures input until button is released)
-  Control provides keyboard/joypad focus via
   `Control.focus_mode`.

This function is `Control._gui_input()`.
Simply override it in your control. No processing needs to be set.

```
extends Control

func _gui_input(event):
   if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
       print("Left mouse button was pressed!")
```

For more information about events themselves, check the [inputevent](../06_inputs/01_inputevent.md) tutorial.

### Notifications

Controls also have many useful notifications for which no dedicated callback
exists, but which can be checked with the _notification callback:

```
func _notification(what):
    match what:
        NOTIFICATION_MOUSE_ENTER:
            pass # Mouse entered the area of this control.
        NOTIFICATION_MOUSE_EXIT:
            pass # Mouse exited the area of this control.
        NOTIFICATION_FOCUS_ENTER:
            pass # Control gained focus.
        NOTIFICATION_FOCUS_EXIT:
            pass # Control lost focus.
        NOTIFICATION_THEME_CHANGED:
            pass # Theme used to draw the control changed;
            # update and redraw is recommended if using a theme.
        NOTIFICATION_VISIBILITY_CHANGED:
            pass # Control became visible/invisible;
            # check new status with is_visible().
        NOTIFICATION_RESIZED:
            pass # Control changed size; check new size
            # with get_size().
        NOTIFICATION_MODAL_CLOSE:
            pass # For modal pop-ups, notification
            # that the pop-up was closed.
```

