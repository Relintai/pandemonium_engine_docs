
# Controllers, gamepads, and joysticks

Pandemonium supports hundreds of controller models thanks to the community-sourced
[SDL game controller database](https://github.com/gabomdq/SDL_GameControllerDB).

Controllers are supported on Windows, macOS, Linux, Android, iOS, and HTML5.

Note that more specialized devices such as steering wheels, rudder pedals and
[HOTAS](https://en.wikipedia.org/wiki/HOTAS) are less tested and may not
always work as expected. Overriding force feedback for those devices is also not
implemented yet.

In this guide, you will learn:

- **How to write your input logic to support both keyboard and controller inputs.**
- **How controllers can behave differently from keyboard/mouse input.**
- **Troubleshooting issues with controllers in Pandemonium.**

## Supporting universal input

Thanks to Pandemonium's input action system, Pandemonium makes it possible to support both
keyboard and controller input without having to write separate code paths.
Instead of hardcoding keys or controller buttons in your scripts, you should
create *input actions* in the Project Settings which will then refer to
specified key and controller inputs.

Input actions are explained in detail on the [inputevent](01_inputevent.md) page.

Note: Unlike keyboard input, supporting both mouse and controller input for an
action (such as looking around in a first-person game) will require
different code paths since these have to be handled separately.

#### Which Input singleton method should I use?

There are 3 ways to get input in an analog-aware way:

- When you have two axes (such as joystick or WASD movement) and want both
  axes to behave as a single input, use `Input.get_vector()`:

```
# `velocity` will be a Vector2 between `Vector2(-1.0, -1.0)` and `Vector2(1.0, 1.0)`.
# This handles deadzone in a correct way for most use cases.
# The resulting deadzone will have a circular shape as it generally should.
var velocity = Input.get_vector("move_left", "move_right", "move_forward", "move_back")

# The line below is similar to `get_vector()`, except that it handles
# the deadzone in a less optimal way. The resulting deadzone will have
# a square-ish shape when it should ideally have a circular shape.
var velocity = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")).clamped(1)
```

- When you have one axis that can go both ways (such as a throttle on a
  flight stick), or when you want to handle separate axes individually,
  use `Input.get_axis()`:

```
# `walk` will be a floating-point number between `-1.0` and `1.0`.
var walk = Input.get_axis("move_left", "move_right")

# The line above is a shorter form of:
var walk = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
```

- For other types of analog input, such as handling a trigger or handling
  one direction at a time, use `Input.get_action_strength()`:

```
# `strength` will be a floating-point number between `0.0` and `1.0`.
var strength = Input.get_action_strength("accelerate")
```

For non-analog digital/boolean input (only "pressed" or "not pressed" values),
such as controller buttons, mouse buttons or keyboard keys,
use `Input.is_action_pressed()`:

```
# `jumping` will be a boolean with a value of `true` or `false`.
var jumping = Input.is_action_pressed("jump")
```

In Pandemonium versions before 3.4, such as 3.3, `Input.get_vector()` and
`Input.get_axis()` aren't available. Only `Input.get_action_strength()`
and `Input.is_action_pressed()` are available in Pandemonium 3.3.

## Differences between keyboard/mouse and controller input

If you're used to handling keyboard and mouse input, you may be surprised by how
controllers handle specific situations.

#### Dead zone

Unlike keyboards and mice, controllers offer axes with *analog* inputs. The
upside of analog inputs is that they offer additional flexibility for actions.
Unlike digital inputs which can only provide strengths of `0.0` and `1.0`,
an analog input can provide *any* strength between `0.0` and `1.0`. The
downside is that without a deadzone system, an analog axis' strength will never
be equal to `0.0` due to how the controller is physically built. Instead, it
will linger at a low value such as `0.062`. This phenomenon is known as
*drifting* and can be more noticeable on old or faulty controllers.

Let's take a racing game as a real-world example. Thanks to analog inputs, we
can steer the car slowly in one direction or another. However, without a
deadzone system, the car would slowly steer by itself even if the player isn't
touching the joystick. This is because the directional axis strength won't be
equal to `0.0` when we expect it to. Since we don't want our car to steer by
itself in this case, we define a "dead zone" value of `0.2` which will ignore
all input whose strength is lower than `0.2`. An ideal dead zone value is high
enough to ignore the input caused by joystick drifting, but is low enough to not
ignore actual input from the player.

Pandemonium features a built-in dead zone system to tackle this problem. The default
value is `0.2`, but you can increase it or decrease it on a per-action basis
in the Project Settings' Input Map tab.
For `Input.get_vector()`, the deadzone can be specified, or otherwise it
will calculate the average deadzone value from all of the actions in the vector.

#### "Echo" events

Unlike keyboard input, holding down a controller button such as a D-pad
direction will **not** generate repeated input events at fixed intervals (also
known as "echo" events). This is because the operating system never sends "echo"
events for controller input in the first place.

If you want controller buttons to send echo events, you will have to generate
`InputEvent` objects by code and parse them using
`Input.parse_input_event()`
at regular intervals. This can be accomplished
with the help of a `Timer` node.

## Troubleshooting

#### My controller isn't recognized by Pandemonium.

First, check that your controller is recognized by other applications. You can
use the [Gamepad Tester](https://gamepad-tester.com/) website to confirm that
your controller is recognized.

#### My controller has incorrectly mapped buttons or axes.

If buttons are incorrectly mapped, this may be due to an erroneous mapping from
the [SDL game controller database](https://github.com/gabomdq/SDL_GameControllerDB).
You can contribute an updated mapping to be included in the next Pandemonium version
by opening a pull request on the linked repository.

There are many ways to create mappings. One option is to use the mapping wizard
in the [Joypads demo](../../07_demo_projects/misc/joypads/).
Once you have a working mapping for your controller, you can test it by defining
the `SDL_GAMECONTROLLERCONFIG` environment variable before running Pandemonium:

bash Linux/macOS:

```
export SDL_GAMECONTROLLERCONFIG="your:mapping:here"
./path/to/pandemonium.x86_64
```

bat Windows (cmd):

```
set SDL_GAMECONTROLLERCONFIG=your:mapping:here
path\to\pandemonium.exe
```

powershell Windows (powershell):

```
$env:SDL_GAMECONTROLLERCONFIG="your:mapping:here"
path\to\pandemonium.exe
```

To test mappings on non-desktop platforms or to distribute your project with
additional controller mappings, you can add them by calling
`Input.add_joy_mapping()`
as early as possible in a script's `ready()` function.

#### My controller works on a given platform, but not on another platform.

### Linux

Prior to Pandemonium 3.3, official Pandemonium binaries were compiled with udev support
but self-compiled binaries were compiled *without* udev support unless
`udev=yes` was passed on the SCons command line. This made controller
hotplugging support unavailable in self-compiled binaries.

### HTML5

HTML5 controller support is often less reliable compared to "native" platforms.
The quality of controller support tends to vary wildly across browsers. As a
result, you may have to instruct your players to use a different browser if they
can't get their controller to work.


