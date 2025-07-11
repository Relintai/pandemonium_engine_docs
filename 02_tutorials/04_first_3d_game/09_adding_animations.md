
# Character animation

In this final lesson, we'll use Pandemonium's built-in animation tools to make our
characters float and flap. You'll learn to design animations in the editor and
use code to make your game feel alive.

![](img/squash-the-creeps-final.gif)

We'll start with an introduction to using the animation editor.

## Using the animation editor

The engine comes with tools to author animations in the editor. You can then use
the code to play and control them at runtime.

Open the player scene, select the player node, and add an *AnimationPlayer* node.

The *Animation* dock appears in the bottom panel.

![](img/09.adding_animations/01.animation_player_dock.png)

It features a toolbar and the animation drop-down menu at the top, a track
editor in the middle that's currently empty, and filter, snap, and zoom options
at the bottom.

Let's create an animation. Click on *Animation -&gt; New*.

![](img/09.adding_animations/02.new_animation.png)

Name the animation "float".

![](img/09.adding_animations/03.float_name.png)

Once you created the animation, the timeline appears with numbers representing
time in seconds.

![](img/09.adding_animations/03.timeline.png)

We want the animation to start playback automatically at the start of the game.
Also, it should loop.

To do so, you can click the button with an "A+" icon in the animation toolbar
and the looping arrows, respectively.

![](img/09.adding_animations/04.autoplay_and_loop.png)

You can also pin the animation editor by clicking the pin icon in the top-right.
This prevents it from folding when you click on the viewport and deselect the
nodes.

![](img/09.adding_animations/05.pin_icon.png)

Set the animation duration to `1.2` seconds in the top-right of the dock.

![](img/09.adding_animations/06.animation_duration.png)

You should see the gray ribbon widen a bit. It shows you the start and end of
your animation and the vertical blue line is your time cursor.

![](img/09.adding_animations/07.editable_timeline.png)

You can click and drag the slider in the bottom-right to zoom in and out of the
timeline.

![](img/09.adding_animations/08.zoom_slider.png)

## The float animation

With the animation player node, you can animate most properties on as many nodes
as you need. Notice the key icon next to properties in the *Inspector*. You can
click any of them to create a keyframe, a time and value pair for the
corresponding property. The keyframe gets inserted where your time cursor is in
the timeline.

Let's insert our first keys. Here, we will animate both the translation and the
rotation of the *Character* node.

Select the *Character* and click the key icon next to *Translation* in the
*Inspector*. Do the same for *Rotation Degrees*.

![](img/09.adding_animations/09.creating_first_keyframe.png)

Two tracks appear in the editor with a diamond icon representing each keyframe.

![](img/09.adding_animations/10.initial_keys.png)

You can click and drag on the diamonds to move them in time. Move the
translation key to `0.2` seconds and the rotation key to `0.1` seconds.

![](img/09.adding_animations/11.moving_keys.png)

Move the time cursor to `0.5` seconds by clicking and dragging on the gray
timeline. In the *Inspector*, set the *Translation*'s *Y* axis to about
`0.65` meters and the *Rotation Degrees*' *X* axis to `8`.

![](img/09.adding_animations/12.second_keys_values.png)

Create a keyframe for both properties and shift the translation key to `0.7`
seconds by dragging it on the timeline.

![](img/09.adding_animations/13.second_keys.png)

Note: A lecture on the principles of animation is beyond the scope of this
tutorial. Just note that you don't want to time and space everything evenly.
Instead, animators play with timing and spacing, two core animation
principles. You want to offset and contrast in your character's motion to
make them feel alive.

Move the time cursor to the end of the animation, at `1.2` seconds. Set the Y
translation to about `0.35` and the X rotation to `-9` degrees. Once again,
create a key for both properties.

You can preview the result by clicking the play button or pressing `Shift + D`.
Click the stop button or press `S` to stop playback.

![](img/09.adding_animations/14.play_button.png)

You can see that the engine interpolates between your keyframes to produce a
continuous animation. At the moment, though, the motion feels very robotic. This
is because the default interpolation is linear, causing constant transitions,
unlike how living things move in the real world.

We can control the transition between keyframes using easing curves.

Click and drag around the first two keys in the timeline to box select them.

![](img/09.adding_animations/15.box_select.png)

You can edit the properties of both keys simultaneously in the *Inspector*,
where you can see an *Easing* property.

![](img/09.adding_animations/16.easing_property.png)

Click and drag on the curve, pulling it towards the left. This will make it
ease-out, that is to say, transition fast initially and slow down as the time
cursor reaches the next keyframe.

![](img/09.adding_animations/17.ease_out.png)

Play the animation again to see the difference. The first half should already
feel a bit bouncier.

Apply an ease-out to the second keyframe in the rotation track.

![](img/09.adding_animations/18.ease_out_second_rotation_key.png)

Do the opposite for the second translation keyframe, dragging it to the right.

![](img/09.adding_animations/19.ease_in_second_translation_key.png)

Your animation should look something like this.

![](img/09.adding_animations/20.float_animation.gif)

Note: Animations update the properties of the animated nodes every frame,
overriding initial values. If we directly animated the *Player* node, it
would prevent us from moving it in code. This is where the *Pivot* node
comes in handy: even though we animated the *Character*, we can still move
and rotate the *Pivot* and layer changes on top of the animation in a
script.

If you play the game, the player's creature will now float!

If the creature is a little too close to the floor, you can move the *Pivot* up
to offset it.

### Controlling the animation in code

We can use code to control the animation playback based on the player's input.
Let's change the animation speed when the character is moving.

Open the *Player*'s script by clicking the script icon next to it.

![](img/09.adding_animations/21.script_icon.png)

In `physics_process()`, after the line where we check the `direction`
vector, add the following code.

```
func _physics_process(delta):
    #...
    #if direction != Vector3.ZERO:
        #...
        $AnimationPlayer.playback_speed = 4
    else:
        $AnimationPlayer.playback_speed = 1
```

This code makes it so when the player moves, we multiply the playback speed by
`4`. When they stop, we reset it to normal.

We mentioned that the pivot could layer transforms on top of the animation. We
can make the character arc when jumping using the following line of code. Add it
at the end of `physics_process()`.

```
func _physics_process(delta):
    #...
    $Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse
```

## Animating the mobs

Here's another nice trick with animations in Pandemonium: as long as you use a similar
node structure, you can copy them to different scenes.

For example, both the *Mob* and the *Player* scenes have a *Pivot* and a
*Character* node, so we can reuse animations between them.

Open the *Player* scene, select the animation player node and open the "float" animation.
Next, click on **Animation &gt; Copy**. Then open `Mob.tscn` and open its animation
player. Click **Animation &gt; Paste**. That's it; all monsters will now play the float
animation.

We can change the playback speed based on the creature's `random_speed`. Open
the *Mob*'s script and at the end of the `initialize()` function, add the
following line.

```
func initialize(start_position, player_position):
    #...
    $AnimationPlayer.playback_speed = random_speed / min_speed
```

And with that, you finished coding your first complete 3D game.

**Congratulations**!

In the next part, we'll quickly recap what you learned and give you some links
to keep learning more. But for now, here are the complete `Player.gd` and
`Mob.gd` so you can check your code against them.

Here's the *Player* script.

```
extends KinematicBody

# Emitted when the player was hit by a mob.
signal hit

# How fast the player moves in meters per second.
export var speed = 14
# The downward acceleration when in the air, in meters per second per second.
export var fall_acceleration = 75
# Vertical impulse applied to the character upon jumping in meters per second.
export var jump_impulse = 20
# Vertical impulse applied to the character upon bouncing over a mob in meters per second.
export var bounce_impulse = 16

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
        $AnimationPlayer.playback_speed = 4
    else:
        $AnimationPlayer.playback_speed = 1

    velocity.x = direction.x * speed
    velocity.z = direction.z * speed

    # Jumping
    if is_on_floor() and Input.is_action_just_pressed("jump"):
        velocity.y += jump_impulse

    velocity.y -= fall_acceleration * delta
    velocity = move_and_slide(velocity, Vector3.UP)

    for index in range(get_slide_count()):
        var collision = get_slide_collision(index)
        if collision.collider.is_in_group("mob"):
            var mob = collision.collider
            if Vector3.UP.dot(collision.normal) > 0.1:
                mob.squash()
                velocity.y = bounce_impulse

    $Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse


func die():
    emit_signal("hit")
    queue_free()


func _on_MobDetector_body_entered(_body):
    die()
```

And the *Mob*'s script.

```
extends KinematicBody

# Emitted when the player jumped on the mob.
signal squashed

# Minimum speed of the mob in meters per second.
export var min_speed = 10
# Maximum speed of the mob in meters per second.
export var max_speed = 18

var velocity = Vector3.ZERO


func _physics_process(_delta):
    move_and_slide(velocity)


func initialize(start_position, player_position):
    look_at_from_position(start_position, player_position, Vector3.UP)
    rotate_y(rand_range(-PI / 4, PI / 4))

    var random_speed = rand_range(min_speed, max_speed)
    velocity = Vector3.FORWARD * random_speed
    velocity = velocity.rotated(Vector3.UP, rotation.y)

    $AnimationPlayer.playback_speed = random_speed / min_speed


 func squash():
    emit_signal("squashed")
    queue_free()


func _on_VisibilityNotifier_screen_exited():
    queue_free()
```


