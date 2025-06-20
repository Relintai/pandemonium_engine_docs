
# 2D Sprite animation

## Introduction

In this tutorial, you'll learn how to create 2D animated
characters with the AnimatedSprite class and the AnimationPlayer. Typically, when you create or download an animated character, it
will come in one of two ways: as individual images or as a single sprite sheet
containing all the animation's frames. Both can be animated in Pandemonium with the AnimatedSprite class.

First, we'll use `AnimatedSprite` to
animate a collection of individual images. Then we will animate a sprite sheet using this class. Finally, we will learn another way to animate a sprite sheet
with `AnimationPlayer` and the *Animation*
property of `Sprite`.

Note: Art for the following examples by https://opengameart.org/users/ansimuz and by https://opengameart.org/users/tgfcoder

## Individual images with AnimatedSprite

In this scenario, you have a collection of images, each containing one of your
character's animation frames. For this example, we'll use the following
animation:

![](img/2d_animation_run_preview.gif)

You can download the images here: [run_animation.zip](files/run_animation.zip)

Unzip the images and place them in your project folder. Set up your scene tree
with the following nodes:

![](img/2d_animation_tree1.png)

Note: The root node could also be `Area2D` or
`RigidBody2D`. The animation will still be
made in the same way. Once the animation is completed, you can
assign a shape to the CollisionShape2D.

Now select the `AnimatedSprite` and in its *SpriteFrames* property, select
"New SpriteFrames".

![](img/2d_animation_new_spriteframes.png)

Click on the new SpriteFrames resource and you'll see a new panel appear at the
bottom of the editor window:

![](img/2d_animation_spriteframes.png)

From the FileSystem dock on the left side, drag the 8 individual images into
the center part of the SpriteFrames panel. On the left side, change the name
of the animation from "default" to "run".

![](img/2d_animation_spriteframes_done.png)

Back in the Inspector, check the box for the *Playing* property. You should
now see the animation playing in the viewport. However, it is a bit slow. To
fix this, change the *Speed (FPS)* setting in the SpriteFrames panel to 10.

You can add additional animations by clicking the "New Animation" button and
adding additional images.

### Controlling the animation

Once the animation is complete, you can control the animation via code using
the `play()` and `stop()` methods. Here is a brief example to play the
animation while the right arrow key is held, and stop it when the key is
released.

```
extends KinematicBody2D

onready var _animated_sprite = $AnimatedSprite

func _process(_delta):
    if Input.is_action_pressed("ui_right"):
        _animated_sprite.play("run")
    else:
        _animated_sprite.stop()
```


## Sprite sheet with AnimatedSprite

You can also easily animate from a sprite sheet with the class `AnimatedSprite`. We will use this public domain sprite sheet:

![](img/2d_animation_frog_spritesheet.png)

Right-click the image and choose "Save Image As" to download it, and then copy the image into your project folder.

Set up your scene tree the same way you did previously when using individual images. Select the `AnimatedSprite` and in its *SpriteFrames* property, select
"New SpriteFrames".

Click on the new SpriteFrames resource. This time, when the bottom panel appears, select "Add frames from a Sprite Sheet".

![](img/2d_animation_add_from_spritesheet.png)

You will be prompted to open a file. Select your sprite sheet.

A new window will open, showing your sprite sheet. The first thing you will need to do is to change the number of
vertical and horizontal images in your sprite sheet. In this sprite sheet, we have four images horizontally
and two images vertically.

![](img/2d_animation_spritesheet_select_rows.png)

Next, select the frames from the sprite sheet that you want to include in your animation. We will select the top four,
then click "Add 4 frames" to create the animation.

![](img/2d_animation_spritesheet_selectframes.png)

You will now see your animation under the list of animations in the bottom panel. Double click on default to change the name of the animation to jump.

![](img/2d_animation_spritesheet_animation.png)

Finally, check Playing on the AnimatedSprite in the inspector to see your frog jump!

![](img/2d_animation_play_spritesheet_animation.png)


## Sprite sheet with AnimationPlayer

Another way that you can animate when using a sprite sheet is to use a standard
`Sprite` node to display the texture, and then animating the
change from texture to texture with `AnimationPlayer`.

Consider this sprite sheet, which contains 6 frames of animation:

![](img/2d_animation_player-run.png)

Right-click the image and choose "Save Image As" to download, then copy the
image into your project folder.

Our goal is to display these images one after another in a loop. Start by
setting up your scene tree:

![](img/2d_animation_tree2.png)

Note: The root node could also be `Area2D` or
`RigidBody2D`. The animation will still be
made in the same way. Once the animation is completed, you can
assign a shape to the CollisionShape2D.

Drag the spritesheet into the Sprite's *Texture* property, and you'll see the
whole sheet displayed on the screen. To slice it up into individual frames,
expand the *Animation* section in the Inspector and set the *Hframes* to `6`.
*Hframes* and *Vframes* are the number of horizontal and vertical frames in
your sprite sheet.

![](img/2d_animation_setframes.png)

Now try changing the value of the *Frame* property. You'll see that it ranges
from `0` to `5` and the image displayed by the Sprite changes accordingly.
This is the property we'll be animating.

Select the `AnimationPlayer` and click the "Animation" button followed by
"New". Name the new animation "walk". Set the animation length to `0.6` and
click the "Loop" button so that our animation will repeat.

![](img/2d_animation_new_animation.png)

Now select the `Sprite` node and click the key icon to add a new track.

![](img/2d_animation_new_track.png)

Continue adding frames at each point in the timeline (`0.1` seconds by
default), until you have all the frames from 0 to 5. You'll see the frames
actually appearing in the animation track:

![](img/2d_animation_full_animation.png)

Press "Play" on the animation to see how it looks.

![](img/2d_animation_running.gif)

### Controlling an AnimationPlayer animation

Like with AnimatedSprite, you can control the animation via code using
the `play()` and `stop()` methods. Again, here is an example to play the
animation while the right arrow key is held, and stop it when the key is
released.

```
extends KinematicBody2D

onready var _animation_player = $AnimationPlayer

func _process(_delta):
    if Input.is_action_pressed("ui_right"):
        _animation_player.play("walk")
    else:
        _animation_player.stop()
```

Note: If updating both an animation and a separate property at once
(for example, a platformer may update the sprite's `h_flip`/`v_flip`
properties when a character turns while starting a 'turning' animation),
it's important to keep in mind that `play()` isn't applied instantly.
Instead, it's applied the next time the `AnimationPlayer` is processed.
This may end up being on the next frame, causing a 'glitch' frame,
where the property change was applied but the animation was not.
If this turns out to be a problem, after calling `play()`, you can call `advance(0)`
to update the animation immediately.

## Summary

These examples illustrate the two classes you can use in Pandemonium for
2D animation. `AnimationPlayer` is
a bit more complex than `AnimatedSprite`, but it provides additional functionality, since you can also
animate other properties like position or scale. The class `AnimationPlayer` can also be used with
an `AnimatedSprite`. Experiment to see what works best for your needs.

