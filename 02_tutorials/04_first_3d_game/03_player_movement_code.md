

# Moving the player with code

It's time to code! We're going to use the input actions we created in the last
part to move the character.

Right-click the *Player* node and select *Attach Script* to add a new script to
it. In the popup, set the *Template* to *Empty* before pressing the *Create*
button.

![](img/03.player_movement_code/01.attach_script_to_player.png)

Let's start with the class's properties. We're going to define a movement speed,
a fall acceleration representing gravity, and a velocity we'll use to move the
character.

```
extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75

var velocity = Vector3.ZERO
```


These are common properties for a moving body. The `velocity` is a 3D vector
combining a speed with a direction. Here, we define it as a property because
we want to update and reuse its value across frames.

Note: The values are quite different from 2D code because distances are in meters.
While in 2D, a thousand units (pixels) may only correspond to half of your
screen's width, in 3D, it's a kilometer.

Let's code the movement now. We start by calculating the input direction vector
using the global `Input` object, in `physics_process()`.

```
func _physics_process(delta):
    # We create a local variable to store the input direction.
    var direction = Vector3.ZERO

    # We check for each move input and update the direction accordingly.
    if Input.is_action_pressed("move_right"):
        direction.x += 1
    if Input.is_action_pressed("move_left"):
        direction.x -= 1
    if Input.is_action_pressed("move_back"):
        # Notice how we are working with the vector's x and z axes.
        # In 3D, the XZ plane is the ground plane.
        direction.z += 1
    if Input.is_action_pressed("move_forward"):
        direction.z -= 1
```

Here, we're going to make all calculations using the `physics_process()`
virtual function. Like `process()`, it allows you to update the node every
frame, but it's designed specifically for physics-related code like moving a
kinematic or rigid body.

We start by initializing a `direction` variable to `Vector3.ZERO`. Then, we
check if the player is pressing one or more of the `move_*` inputs and update
the vector's `x` and `z` components accordingly. These correspond to the
ground plane's axes.

These four conditions give us eight possibilities and eight possible directions.

In case the player presses, say, both W and D simultaneously, the vector will
have a length of about `1.4`. But if they press a single key, it will have a
length of `1`. We want the vector's length to be consistent. To do so, we can
call its `normalize()` method.

```
#func _physics_process(delta):
    #...

    if direction != Vector3.ZERO:
        direction = direction.normalized()
        $Pivot.look_at(translation + direction, Vector3.UP)
```

Here, we only normalize the vector if the direction has a length greater than
zero, which means the player is pressing a direction key.

In this case, we also get the *Pivot* node and call its `look_at()` method.
This method takes a position in space to look at in global coordinates and the
up direction. In this case, we can use the `Vector3.UP` constant.

Note: A node's local coordinates, like `translation`, are relative to their
parent. Global coordinates are relative to the world's main axes you can see
in the viewport instead.

In 3D, the property that contains a node's position is `translation`. By
adding the `direction` to it, we get a position to look at that's one meter
away from the *Player*.

Then, we update the velocity. We have to calculate the ground velocity and the
fall speed separately. Be sure to go back one tab so the lines are inside the
`physics_process()` function but outside the condition we just wrote.

```
func _physics_process(delta):
    #...
    if direction != Vector3.ZERO:
        #...

    # Ground velocity
    velocity.x = direction.x * speed
    velocity.z = direction.z * speed
    # Vertical velocity
    velocity.y -= fall_acceleration * delta
    # Moving the character
    velocity = move_and_slide(velocity, Vector3.UP)
```

For the vertical velocity, we subtract the fall acceleration multiplied by the
delta time every frame. Notice the use of the `-=` operator, which is a
shorthand for `variable = variable - ...`.

This line of code will cause our character to fall in every frame. This may seem
strange if it's already on the floor. But we have to do this for the character
to collide with the ground every frame.

The physics engine can only detect interactions with walls, the floor, or other
bodies during a given frame if movement and collisions happen. We will use this
property later to code the jump.

On the last line, we call `KinematicBody.move_and_slide()`. It's a powerful
method of the `KinematicBody` class that allows you to move a character
smoothly. If it hits a wall midway through a motion, the engine will try to
smooth it out for you.

The function takes two parameters: our velocity and the up direction. It moves
the character and returns a leftover velocity after applying collisions. When
hitting the floor or a wall, the function will reduce or reset the speed in that
direction from you. In our case, storing the function's returned value prevents
the character from accumulating vertical momentum, which could otherwise get so
big the character would move through the ground slab after a while.

And that's all the code you need to move the character on the floor.

Here is the complete `Player.gd` code for reference.

```
extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75

var velocity = Vector3.ZERO


func _physics_process(delta):
    var direction = Vector3.ZERO

    if Input.is_action_pressed("move_right"):
        direction.x += 1
    if Input.is_action_pressed("move_left"):
        direction.x -= 1
    if Input.is_action_pressed("move_back"):
        direction.z += 1
    if Input.is_action_pressed("move_forward"):
        direction.z -= 1

    if direction != Vector3.ZERO:
        direction = direction.normalized()
        $Pivot.look_at(translation + direction, Vector3.UP)

    velocity.x = direction.x * speed
    velocity.z = direction.z * speed
    velocity.y -= fall_acceleration * delta
    velocity = move_and_slide(velocity, Vector3.UP)
```

## Testing our player's movement

We're going to put our player in the *Main* scene to test it. To do so, we need
to instantiate the player and then add a camera. Unlike in 2D, in 3D, you won't
see anything if your viewport doesn't have a camera pointing at something.

Save your *Player* scene and open the *Main* scene. You can click on the *Main*
tab at the top of the editor to do so.

![](img/03.player_movement_code/02.clicking_main_tab.png)

If you closed the scene before, head to the *FileSystem* dock and double-click
`Main.tscn` to re-open it.

To instantiate the *Player*, right-click on the *Main* node and select *Instance
Child Scene*.

![](img/03.player_movement_code/03.instance_child_scene.png)

In the popup, double-click *Player.tscn*. The character should appear in the
center of the viewport.

## Adding a camera

Let's add the camera next. Like we did with our *Player*\ 's *Pivot*, we're
going to create a basic rig. Right-click on the *Main* node again and select
*Add Child Node* this time. Create a new *Position3D*, name it *CameraPivot*,
and add a *Camera* node as a child of it. Your scene tree should look like this.

![](img/03.player_movement_code/04.scene_tree_with_camera.png)

Notice the *Preview* checkbox that appears in the top-left when you have the
*Camera* selected. You can click it to preview the in-game camera projection.

![](img/03.player_movement_code/05.camera_preview_checkbox.png)

We're going to use the *Pivot* to rotate the camera as if it was on a crane.
Let's first split the 3D view to be able to freely navigate the scene and see
what the camera sees.

In the toolbar right above the viewport, click on *View*, then *2 Viewports*.
You can also press `Ctrl + 2` (`Cmd + 2` on macOS).

![](img/03.player_movement_code/06.two_viewports.png)

On the bottom view, select the *Camera* and turn on camera preview by clicking
the checkbox.

![](img/03.player_movement_code/07.camera_preview_checkbox.png)

In the top view, move the camera about `19` units on the Z axis (the blue
one).

![](img/03.player_movement_code/08.camera_moved.png)

Here's where the magic happens. Select the *CameraPivot* and rotate it `45`
degrees around the X axis (using the red circle). You'll see the camera move as
if it was attached to a crane.

![](img/03.player_movement_code/09.camera_rotated.png)

You can run the scene by pressing `F6` and press the arrow keys to move the
character.

![](img/03.player_movement_code/10.camera_perspective.png)

We can see some empty space around the character due to the perspective
projection. In this game, we're going to use an orthographic projection instead
to better frame the gameplay area and make it easier for the player to read
distances.

Select the *Camera* again and in the *Inspector*, set the *Projection* to
*Orthogonal* and the *Size* to `19`. The character should now look flatter and
the ground should fill the background.

![](img/03.player_movement_code/11.camera_orthographic.png)

With that, we have both player movement and the view in place. Next, we will
work on the monsters.

