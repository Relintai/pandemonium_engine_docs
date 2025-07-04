
# Idle and Physics Processing

Games run in a loop. Each frame, you need to update the state of your game world
before drawing it on screen. Pandemonium provides two virtual methods in the Node
class to do so: `Node._process()` and
`Node._physics_process()`. If you
define either or both in a script, the engine will call them automatically.

There are two types of processing available to you:

1. **Idle processing** allows you to run code that updates a node every frame,
   as often as possible.
2. **Physics processing** happens at a fixed rate, 60 times per second by
   default. This is independent of your game's actual framerate, and keeps physics
   running smoothly. You should use it for anything that involves the physics
   engine, like moving a body that collides with the environment.

You can activate idle processing by defining the `process()` method in a
script. You can turn it off and back on by calling `Node.set_process()`.

The engine calls this method every time it draws a frame:

```
func _process(delta):
    # Do something...
    pass
```

Keep in mind that the frequency at which the engine calls `process()` depends
on your application's framerate, which varies over time and across devices.

The function's `delta` parameter is the time elapsed in seconds since the
previous call to `process()`. Use this parameter to make calculations
independent of the framerate. For example, you should always multiply a speed
value by `delta` to animate a moving object.

Physics processing works with a similar virtual function:
`physics_process()`. Use it for calculations that must happen before each
physics step, like moving a character that collides with the game world. As
mentioned above, `physics_process()` runs at fixed time intervals as much as
possible to keep the physics interactions stable. You can change the interval
between physics steps in the Project Settings, under Physics -> Common ->
Physics Fps. By default, it's set to run 60 times per second.

The engine calls this method every time it draws a frame:

```
func _physics_process(delta):
    # Do something...
    pass
```

The function `process()` is not synchronized with physics. Its rate depends on
hardware and game optimization. It also runs after the physics step in
single-threaded games.

You can see the `process()` function at work by creating a scene with a
single Label node, with the following script attached to it:

```
extends Label

var time = 0

func _process(delta):
    time += delta
    text = str(time) # 'text' is a built-in Label property.
```

When you run the scene, you should see a counter increasing each frame.

