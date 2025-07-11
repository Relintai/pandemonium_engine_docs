
# Input examples

## Introduction

In this tutorial, you'll learn how to use Pandemonium's `InputEvent`
system to capture player input. There are many different types of input your
game may use - keyboard, gamepad, mouse, etc. - and many different ways to
turn those inputs into actions in your game. This document will show you some
of the most common scenarios, which you can use as starting points for your
own projects.

Note: For a detailed overview of how Pandemonium's input event system works,
see [this](01_inputevent.md).

## Events versus polling

Sometimes you want your game to respond to a certain input event - pressing
the "jump" button, for example. For other situations, you might want something
to happen as long as a key is pressed, such as movement. In the first case,
you can use the `input()` function, which will be called whenever an input
event occurs. In the second case, Pandemonium provides the `Input`
singleton, which you can use to query the state of an input.

Examples:

```
func _input(event):
    if event.is_action_pressed("jump"):
        jump()


func _physics_process(delta):
    if Input.is_action_pressed("move_right"):
        # Move as long as the key/button is pressed.
        position.x += speed * delta
```

This gives you the flexibility to mix-and-match the type of input processing
you do.

For the remainder of this tutorial, we'll focus on capturing individual
events in `input()`.

## Input events

Input events are objects that inherit from `InputEvent`.
Depending on the event type, the object will contain specific properties
related to that event. To see what events actually look like, add a Node and
attach the following script:

```
extends Node


func _input(event):
    print(event.as_text())
```

As you press keys, move the mouse, and perform other inputs, you'll see each
event scroll by in the output window. Here's an example of the output:

```
A
InputEventMouseMotion : button_mask=0, position=(108, 108), relative=(26, 1), speed=(164.152496, 159.119843), pressure=(0), tilt=(0, 0)
InputEventMouseButton : button_index=BUTTON_LEFT, pressed=true, position=(108, 107), button_mask=1, doubleclick=false
InputEventMouseButton : button_index=BUTTON_LEFT, pressed=false, position=(108, 107), button_mask=0, doubleclick=false
S
F
Alt
InputEventMouseMotion : button_mask=0, position=(108, 107), relative=(0, -1), speed=(164.152496, 159.119843), pressure=(0), tilt=(0, 0)
```

As you can see, the results are very different for the different types of
input. Key events are even printed as their key symbols. For example, let's
consider `InputEventMouseButton`.
It inherits from the following classes:

- `InputEvent` - the base class for all input events
- `InputEventWithModifiers` - adds the ability to check if modifiers are pressed, such as `Shift` or `Alt`.
- `InputEventMouse` - adds mouse event properties, such as `position`
- `InputEventMouseButton` - contains the index of the button that was pressed, whether it was a double-click, etc.

Tip: It's a good idea to keep the class reference open while you're working
with events so you can check the event type's available properties and
methods.

You can encounter errors if you try to access a property on an input type that
doesn't contain it - calling `position` on `InputEventKey` for example. To
avoid this, make sure to test the event type first:

```
func _input(event):
    if event is InputEventMouseButton:
        print("mouse button event at ", event.position)
```

## InputMap

The `InputMap` is the most flexible way to handle a
variety of inputs. You use this by creating named input *actions*, to which
you can assign any number of input events, such as keypresses or mouse clicks.
A new Pandemonium project includes a number of default actions already defined. To
see them, and to add your own, open Project -> Project Settings and select
the InputMap tab:

![](img/inputs_inputmap.png)

### Capturing actions

Once you've defined your actions, you can process them in your scripts using
`is_action_pressed()` and `is_action_released()` by passing the name of
the action you're looking for:

```
func _input(event):
    if event.is_action_pressed("my_action"):
        print("my_action occurred!")
```

## Keyboard events

Keyboard events are captured in `InputEventKey`.
While it's recommended to use input actions instead, there may be cases where
you want to specifically look at key events. For this example, let's check for
the `T`:

```
func _input(event):
    if event is InputEventKey and event.pressed:
        if event.scancode == KEY_T:
            print("T was pressed")
```

Tip: See the `KeyList` enum for a list of scancode constants.

Warning:

- Due to *keyboard ghosting*, not all key inputs may be registered at a given time
  if you press too many keys at once. Due to their location on the keyboard,
  certain keys are more prone to ghosting than others. Some keyboards feature
  antighosting at a hardware level, but this feature is generally
  not present on low-end keyboards and laptop keyboards.
- As a result, it's recommended to use a default keyboard layout that is designed to work well
  on a keyboard without antighosting. See
  [this Gamedev Stack Exchange question](https://gamedev.stackexchange.com/a/109002)
  for more information.

### Keyboard modifiers

Modifier properties are inherited from
`InputEventWithModifiers`. This allows
you to check for modifier combinations using boolean properties. Let's imagine
you want one thing to happen when the `T` is pressed, but something
different when it's `Shift + T`:

```
func _input(event):
    if event is InputEventKey and event.pressed:
        if event.scancode == KEY_T:
            if event.shift:
                print("Shift+T was pressed")
            else:
                print("T was pressed")
```

Tip: See the `KeyList` enum for a list of scancode constants.

## Mouse events

Mouse events stem from the `InputEventMouse` class, and
are separated into two types: `InputEventMouseButton`
and `InputEventMouseMotion`. Note that this
means that all mouse events will contain a `position` property.

### Mouse buttons

Capturing mouse buttons is very similar to handling key events. The `ButtonList` enum
contains a list of `BUTTON_*` constants for each possible button, which will
be reported in the event's `button_index` property. Note that the scrollwheel
also counts as a button - two buttons, to be precise, with both
`BUTTON_WHEEL_UP` and `BUTTON_WHEEL_DOWN` being separate events.

```
func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT and event.pressed:
            print("Left button was clicked at ", event.position)
        if event.button_index == BUTTON_WHEEL_UP and event.pressed:
            print("Wheel up")
```

### Mouse motion

`InputEventMouseMotion` events occur whenever
the mouse moves. You can find the move's distance with the `relative`
property.

Here's an example using mouse events to drag-and-drop a `Sprite`
node:

```
extends Node


var dragging = false
var click_radius = 32 # Size of the sprite.


func _input(event):
    if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
        if (event.position - $Sprite.position).length() (  click_radius:
            # Start dragging if the click is on the sprite.
            if not dragging and event.pressed:
                dragging = true
        # Stop dragging if the button is released.
        if dragging and not event.pressed:
            dragging = false

    if event is InputEventMouseMotion and dragging:
        # While dragging, move the sprite with the mouse.
        $Sprite.position = event.position
```

## Touch events

If you are using a touchscreen device, you can generate touch events.
`InputEventScreenTouch` is equivalent to
a mouse click event, and `InputEventScreenDrag`
works much the same as mouse motion.

Tip: To test your touch events on a non-touchscreen device, open Project
Settings and go to the "Input Devices/Pointing" section. Enable "Emulate
Touch From Mouse" and your project will interpret mouse clicks and
motion as touch events.

