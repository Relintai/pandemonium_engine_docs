
# Introduction to the animation features

The `AnimationPlayer` node allows you to create anything
from simple to complex animations.

In this guide you learn to:

-  Work with the Animation Panel
-  Animate any property of any node
-  Create a simple animation
-  Call functions with the powerful Call Function Tracks

In Pandemonium, you can animate anything available in the Inspector, such as
Node transforms, sprites, UI elements, particles, visibility and color
of materials, and so on. You can also modify values of script variables
and call any function.

## Create an AnimationPlayer node

To use the animation tools we first have to create an
`AnimationPlayer` node.

The AnimationPlayer node type is the data container for your animations.
One AnimationPlayer node can hold multiple animations, that can
automatically transition to one another.

![The AnimationPlayer node](img/animation_create_animationplayer.png)

The AnimationPlayer node

After creating one click on the AnimationPlayer node in the Node tab to
open the Animation Panel at the bottom of the viewport.

![The animation panel position](img/animation_animation_panel.png)

The animation panel position

It consists of four parts:

![The animation panel](img/animation_animation_panel_overview.png)

The animation panel

-  Animation controls (i.e. add, load, save, and delete animations)
-  The tracks listing
-  The timeline with keyframes
-  The timeline and track controls, where you can zoom the timeline and
   edit tracks for example.

## Computer animation relies on keyframes

A keyframe defines the value of a property at a certain point in time.

Diamond shapes represent keyframes in the timeline. A line between two
keyframes indicates that the value hasn't changed.

![Keyframes in Pandemonium](img/animation_keyframes.png)

Keyframes in Pandemonium

The engine interpolates values between keyframes, resulting in a gradual
change in values over time.

![Two keyframes are all it takes to obtain a smooth motion](img/animation_illustration.png)

Two keyframes are all it takes to obtain a smooth motion

The timeline lets you insert keyframes and change their timing. It also
defines how long the animation is.

![The timeline in the animation panel](img/animation_timeline.png)

The timeline in the animation panel

Each line of the Animation Panel is an animation track. Normal and
Transform tracks reference node properties. Their name or id is a path
to the node and the affected property.

![Example of Normal animation tracks](img/animation_normal_track.png)

Example of Normal animation tracks

Tip: If you animate the wrong property, you can edit a track's path anytime.
Double click on it and type the new path. Play the animation using the
"Play from beginning" button |Play from beginning| (or pressing
`Shift + D` on keyboard) to see the changes instantly.

## Tutorial: Creating a simple animation

### Scene setup

For this tutorial, we'll create a Sprite node with an AnimationPlayer as
its child. We will animate the sprite to move between two points on the screen.

![Our scene setup](img/animation_animation_player_tree.png)

Our scene setup

Warning: AnimationPlayer inherits from Node instead of Node2D or Spatial, which means
that the child nodes will not inherit the transform from the parent nodes
due to a bare Node being present in the hierarchy.
Therefore, it is not recommended to add nodes that have a 2D/3D transform
as a child of an AnimationPlayer node.

The sprite holds an image texture. We animate that sprite to move
between two points on the screen. For this tutorial, use the default Pandemonium
icon as the sprite's texture. As a starting point, move the sprite
to a left position on the screen.

Select the AnimationPlayer node, then click the "Animation" button in the
animation editor. From the list select "New" (|Add
Animation|) to add a new animation. And Enter a name for the animation in the
dialog box.

![Add a new animation](img/animation_create_new_animation.png)

Add a new animation

### Adding a track

To add a new track for our sprite, select it and take a look in the
toolbar:

![Convenience buttons](img/animation_convenience_buttons.png)

Convenience buttons

These switches and buttons allow you to add keyframes for the selected
node's location, rotation, and scale respectively.

Deselect rotation, because we are only interested in the location of our
sprite for this tutorial and click on the key button.

As we don't have a track already set up for the transform/location
property, Pandemonium asks whether it should set it up for us. Click **Create**.

This creates a new track and our first keyframe at the beginning of
the timeline:

![The sprite track](img/animation_track.png)

The sprite track

### The second keyframe

Now we need to set the destination where our sprite should be headed and
how much time it takes to get there.

Let's say, we want it to take 2 seconds to go to the other point. By
default the animation is set to last only 1 second, so change this in
the timeline controls in animation panel's lower panel to 2.

![Animation length](img/animation_set_length.png)

Animation length

Click on the timeline header near the 2-second mark and move the sprite
to the target destination on the right side.

Again, click the key button in the toolbar. This creates our second
keyframe.

### Run the animation

Click on the "Play from beginning" (|Play from beginning|) button.

Yay! Our animation runs:

![The animation](img/animation_simple.gif)

The animation

### Back and forth

Pandemonium has an additional feature here. Like said before,
Pandemonium always calculates the frames between two keyframes. In a loop, the
first keyframe is also the last keyframe, if no keyframe is specified at
the end.

![Animation loop](img/animation_loop.png)

Animation loop

If you set the animation length to 4 seconds now, the animation moves
back and forth. You can change this behavior if you change the track's
loop mode. This is covered in the next chapter.

### Track settings

Each track has a settings panel at the end, where you can set the update
mode, the track interpolation, and the loop mode.

![Track settings](img/animation_track_settings.png)

Track settings

The update mode of a track tells Pandemonium when to update the property
values. This can be:

-  **Continuous:** Update the property on each frame.
-  **Discrete:** Only update the property on keyframes.
-  **Trigger:** Only update the property on keyframes or triggers.
   Triggers are a type of keyframe used by the
   `current_animation` property of a `AnimationPlayer`,
   and Animation Playback tracks.
-  **Capture:** If the first keyframe's time is greater than `0.0`, the
   current value of the property will be remembered and
   will be blended with the first animation key. For example, you
   could use the Capture mode to move a node that's located anywhere
   to a specific location.

![Track mode](img/animation_track_rate.png)

Track mode

In normal animations, you usually use "Continuous". The other types are
used to script complex animations.

The interpolation tells Pandemonium how to calculate the frame values between
the keyframes. These interpolation modes are supported:

-  Nearest: Set the nearest keyframe value
-  Linear: Set the value based on a linear function calculation between
   the two keyframes
-  Cubic: Set the value based on a cubic function calculation between
   the two keyframes

![Track interpolation](img/animation_track_interpolation.png)

Track interpolation

Cubic interpolation leads to a more natural movement, where the
animation is slower at a keyframe and faster between keyframes. This is
usually used for character animation. Linear interpolation creates more
of a robotic movement.

Pandemonium supports two loop modes, which affect the animation if it's set to
loop:

![Loop modes](img/animation_track_loop_modes.png)

Loop modes

-  Clamp loop interpolation: When this is selected, the animation stops
   after the last keyframe for this track. When the first keyframe is
   reached again, the animation will reset to its values.
-  Wrap loop interpolation: When this is selected, Pandemonium calculates the
   animation after the last keyframe to reach the values of the first
   keyframe again.

## Keyframes for other properties

Pandemonium doesn't restrict you to only edit transform properties. Every
property can be used as a track where you can set keyframes.

If you select your sprite while the animation panel is visible, you get
a small keyframe button for all the sprite's properties. Click on
this button and Pandemonium automatically adds a track and keyframe to the
current animation.

![Keyframes for other properties](img/animation_properties_keyframe.png)

Keyframes for other properties

## Edit keyframes

For advanced use and to edit keyframes in detail, You can click on them
to bring up the keyframe editor in the inspector. You can use this to
directly edit its values.

![Keyframe editor editing a key](img/animation_keyframe_editor_key.png)

Keyframe editor editing a key

Additionally, you can also edit the easing value for this keyframe by
clicking and dragging the easing setting. This tells Pandemonium, how to change
the property values when it reaches this keyframe.

You usually tweak your animations this way, when the movement doesn't
"look right".

## Advanced: Call Method tracks

Pandemonium's animation engine doesn't stop here. If you're already
comfortable with Pandemonium's scripting language
you know that each node type is a class and has a bunch of callable
methods.

For example, the `AudioStreamPlayer` node type has a
method to play an audio stream.

Wouldn't it be great to use a method at a specific keyframe in an
animation? This is where "Call Method Tracks" come in handy. These tracks
reference a node again, this time without a reference to a property.
Instead, a keyframe holds the name and arguments of a method, that
Pandemonium should call when it reaches this keyframe.

To demonstrate, we're going to use a call method track to play audio at a
specific keyframe. Normally to play audio you should use an audio track,
but for the sake of demonstrating methods we're going to do it this way.

Add a `AudioStreamPlayer` to the Scene Tree and setup a
stream using an audio file you put in your project.

Click on "Add track" (|Add track|) on the animation panel's track
controls.

Select "Add Call Method Track" from the list of possible track types.

![Add Call Method Track](img/animation_add_call_method_track.png)

Add Call Method Track

Select the `AudioStreamPlayer` node in the selection
window. Pandemonium adds the track with the reference to the node.

![Select AudioStreamPlayer](img/animation_select_audiostreamplayer.png)

Select AudioStreamPlayer

Right click the timeline where Pandemonium should play the sample and
click the "Insert Key" option. This will bring up a list of methods
that can be called for the AudioStreamPlayer node. Select the first
one.

![](img/animation_method_options.png)

When Pandemonium reaches the keyframe, Pandemonium calls the
`AudioStreamPlayer` node's "play" function and the stream
plays.

You can change its position by dragging it on the timeline, you can also
click on the keyframe and use the keyframe settings in the inspector.

![](img/animation_call_method_keyframe.png)

![Play from beginning](img/animation_play_from_beginning.png)

Play from beginning

![Add Animation](img/animation_add.png)

Add Animation

![Add track](img/animation_add_track.png)

## Using RESET tracks

You can set up a special *RESET* animation to contain the "default pose".
This is used to ensure that the default pose is restored when you save
the scene and open it again in the editor.

For existing tracks, you can add an animation called "RESET" (case-sensitive),
then add tracks for each property that you want to reset.
The only keyframe should be at time 0, and give it the desired default value
for each track.

If AnimationPlayer's **Reset On Save** property is set to `true`,
the scene will be saved with the effects of the reset animation applied
(as if it had been seeked to time `0.0`).
This only affects the saved file – the property tracks in the editor stay
where they were.

If you want to reset the tracks in the editor, select the AnimationPlayer node,
open the **Animation** bottom panel then choose **Apply Reset** in the
animation editor's **Animation** dropdown menu.

When adding tracks on new animations, the editor will ask you to automatically
create a RESET track when using the keyframe icon next to a property in the inspector.
This does not apply on tracks created with Pandemonium versions prior to 3.4,
as the animation reset track feature was added in 3.4.

