
# Using AnimationTree

## Introduction

With `AnimationPlayer`, Pandemonium has one of the most flexible animation systems that you can find in any game engine.
The ability to animate almost any property in any node or resource, as well as having dedicated transform, bezier,
function calling, audio and sub-animation tracks, is pretty much unique.

However, the support for blending those animations via `AnimationPlayer` is relatively limited, as only a fixed cross-fade transition time can be set.

`AnimationTree` is a new node introduced in Pandemonium 3.1 to deal with advanced transitions.
It supersedes the ancient `AnimationTreePlayer`, while adding a huge amount of features and flexibility.

## Creating an AnimationTree

Before starting, it must be made clear that an `AnimationTree` node does not contain its own animations.
Instead, it uses animations contained in an `AnimationPlayer` node. This way, you can edit your animations (or import them from a 3D scene)
as usual and then use this extra node to control the playback.

The most common way to use `AnimationTree` is in a 3D scene. When importing your scenes from a 3D exchange format, they will usually come
with animations built-in (either multiple ones or split from a large one on import).
At the end, the imported Pandemonium scene will contain the animations in a `AnimationPlayer` node.

As you rarely use imported scenes directly in Pandemonium (they are either instantiated or inherited from), you can place the `AnimationTree` node in your
new scene which contains the imported one. Afterwards, point the `AnimationTree` node to the `AnimationPlayer` that was created in the imported scene.

This is how it's done in the Third Person Shooter demo, for reference:

![](img/animtree1.png)

A new scene was created for the player with a `KinematicBody` as root. Inside this scene, the original `.dae` (Collada) file was instantiated
and an `AnimationTree` node was created.

## Creating a tree

There are three main types of nodes that can be used in `AnimationTree`:

1. Animation nodes, which reference an animation from the linked `AnimationTree`.
2. Animation Root nodes, which are used to blend sub-nodes.
3. Animation Blend nodes, which are used within `AnimationNodeBlendTree` as single-graph blending via multiple input ports.

To set a root node in `AnimationTree`, a few types are available:

![](img/animtree2.png)

* `AnimationNodeAnimation`: Selects an animation from the list and plays it. This is the simplest root node, and generally not used directly as root.
* `AnimationNodeBlendTree`: Contains many *blend* type nodes, such as mix, blend2, blend3, one shot, etc. This is one of the most commonly used roots.
* `AnimationNodeStateMachine`: Contains multiple root nodes as children in a graph. Each node is used as a *state*, and provides
  multiple functions to alternate between states.
* `AnimationNodeBlendSpace2D`: Allows placing root nodes in a 2D blend space. Control the blend position in 2D to mix between multiple animations.
* `AnimationNodeBlendSpace1D`: Simplified version of the above (1D).

## Blend tree

An `AnimationNodeBlendTree` can contain both root and regular nodes used for blending. Nodes are added to the graph from a menu:

![](img/animtree3.png)

All blend trees contain an `Output` node by default, and something has to be connected to it in order for animations to play.

The easiest way to test this functionality is to connect an `Animation` node to it directly:

![](img/animtree4.png)

This will simply play back the animation. Make sure that the `AnimationTree` is active for something to actually happen.

Following is a short description of available nodes:

#### Blend2 / Blend3

These nodes will blend between two or three inputs by a user-specified blend value:

![](img/animtree5.gif)

For more complex blending, it is advised to use blend spaces instead.

Blending can also use filters, i.e. you can control individually which tracks go through the blend function.
This is very useful for layering animations on top of each other.

![](img/animtree6.png)

#### OneShot

This node will execute a sub-animation and return once it finishes. Blend times for fading in and out can be customized, as well as filters.

![](img/animtree6b.gif)

#### Seek

This node can be used to cause a seek command to happen to any sub-children of the animation graph. Use this node type
to play an `Animation` from the start or a certain playback position inside the `AnimationNodeBlendTree`.

After setting the time and changing the animation playback, the seek node automatically goes into sleep mode on the next
process frame by setting its `seek_position` value to `-1.0`.

```
# Play child animation from the start.
anim_tree.set("parameters/Seek/seek_position", 0.0)
# Alternative syntax (same result as above).
anim_tree["parameters/Seek/seek_position"] = 0.0

# Play child animation from 12 second timestamp.
anim_tree.set("parameters/Seek/seek_position", 12.0)
# Alternative syntax (same result as above).
anim_tree["parameters/Seek/seek_position"] = 12.0
```

#### TimeScale

Allows scaling the speed of the animation (or reverse it) in any children nodes. Setting it to 0 will pause the animation.

#### Transition

Very simple state machine (when you don't want to cope with a `StateMachine` node). Animations can be
connected to the outputs and transition times can be specified.

#### BlendSpace2D

`BlendSpace2D` is a node to do advanced blending in two dimensions. Points are added to a two-dimensional space and then a position
can be controlled to determine blending:

![](img/animtree7.gif)

The ranges in X and Y can be controlled (and labeled for convenience). By default, points can be placed anywhere (just right-click on
the coordinate system or use the *add point* button) and triangles will be generated automatically using Delaunay.

![](img/animtree8.gif)

It is also possible to draw the triangles manually by disabling the *auto triangle* option, though this is rarely necessary:

![](img/animtree9.png)

Finally, it is possible to change the blend mode. By default, blending happens by interpolating points inside the closest triangle.
When dealing with 2D animations (frame by frame), you may want to switch to *Discrete* mode.
Alternatively, if you want to keep the current play position when switching between discrete animations, there is a *Carry* mode.
This mode can be changed in the *Blend* menu:

![](img/animtree10.png)

#### BlendSpace1D

This is similar to 2D blend spaces, but in one dimension (so triangles are not needed).

#### StateMachine

This node acts as a state machine with root nodes as states. Root nodes can be created and connected via lines. States are connected via *Transitions*,
which are connections with special properties. Transitions are uni-directional, but two can be used to connect in both directions.

![](img/animtree11.gif)

There are many types of transition:

![](img/animtree12.png)

* *Immediate*: Will switch to the next state immediately. The current state will end and blend into the beginning of the new one.
* *Sync*: Will switch to the next state immediately, but will seek the new state to the playback position of the old state.
* *At End*: Will wait for the current state playback to end, then switch to the beginning of the next state animation.

Transitions also have a few properties. Click any transition and it will be displayed in the inspector dock:

![](img/animtree13.png)

* *Switch Mode* is the transition type (see above), it can be modified after creation here.
* *Auto Advance* will turn on the transition automatically when this state is reached. This works best with the *At End* switch mode.
* *Advance Condition* will turn on auto advance when this condition is set. This is a custom text field that can be filled with a variable name.
  The variable can be modified from code (more on this later).
* *Xfade Time* is the time to cross-fade between this state and the next.
* *Priority* is used together with the `travel()` function from code (more on this later). Lower priority transitions
  are preferred when travelling through the tree.
* *Disabled* toggles disabling this transition (when disabled, it will not be used during travel or auto advance).


## Root motion

When working with 3D animations, a popular technique is for animators to use the root skeleton bone to give motion to the rest of the skeleton.
This allows animating characters in a way where steps actually match the floor below. It also allows precise interaction with objects during cinematics.

When playing back the animation in Pandemonium, it is possible to select this bone as the *root motion track*. Doing so will cancel the bone
transformation visually (the animation will stay in place).

![](img/animtree14.png)

Afterwards, the actual motion can be retrieved via the `AnimationTree` API as a transform:

```
anim_tree.get_root_motion_transform()
```

This can be fed to functions such as `KinematicBody.move_and_slide` to control the character movement.

There is also a tool node, `RootMotionView`, that can be placed in a scene and will act as a custom floor for your
character and animations (this node is disabled by default during the game).

![](img/animtree15.gif)


## Controlling from code

After building the tree and previewing it, the only question remaining is "How is all this controlled from code?".

Keep in mind that the animation nodes are just resources and, as such, they are shared between all instances using them.
Setting values in the nodes directly will affect all instances of the scene that uses this `AnimationTree`.
This is generally undesirable, but does have some cool use cases, e.g. you can copy and paste parts of your animation tree,
or reuse nodes with a complex layout (such as a state machine or blend space) in different animation trees.

The actual animation data is contained in the `AnimationTree` node and is accessed via properties.
Check the "Parameters" section of the `AnimationTree` node to see all the parameters that can be modified in real-time:

![](img/animtree16.png)

This is handy because it makes it possible to animate them from an `AnimationPlayer`, or even the `AnimationTree` itself,
allowing the realization of very complex animation logic.

To modify these values from code, the property path must be obtained. This is done easily by hovering the mouse over any of the parameters:

![](img/animtree17.png)

Which allows setting them or reading them:

```
anim_tree.set("parameters/eye_blend/blend_amount", 1.0)
# Simpler alternative form:
anim_tree["parameters/eye_blend/blend_amount"] = 1.0
```


## State machine travel

One of the nice features in Pandemonium's `StateMachine` implementation is the ability to travel. The graph can be instructed to go from the
current state to another one, while visiting all the intermediate ones. This is done via the A\* algorithm.
In the absence of any viable set of transitions starting at the current state and finishing at the destination state, the graph teleports
to the destination state.

To use the travel ability, you should first retrieve the `AnimationNodeStateMachinePlayback`
object from the `AnimationTree` node (it is exported as a property).


```
var state_machine = anim_tree["parameters/playback"]
```

Once retrieved, it can be used by calling one of the many functions it offers:

```
state_machine.travel("SomeState")
```

The state machine must be running before you can travel. Make sure to either call `start()` or choose a node to **Autoplay on Load**.

![](img/animtree18.png)

