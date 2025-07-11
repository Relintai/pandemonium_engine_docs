
# Optimization using Servers

Engines like Pandemonium provide increased ease of use thanks to their high level constructs and features.
Most of them are accessed and used via the `Scene System`. Using nodes and
resources simplifies project organization and asset management in complex games.

There are, of course, always drawbacks:

* There is an extra layer of complexity
* Performance is lower than using simple APIs directly
* It is not possible to use multiple threads to control them
* More memory is needed.

In many cases, this is not really a problem (Pandemonium is very optimized, and most operations are handled
with signals, so no polling is required). Still, sometimes it can be. For example, dealing with
tens of thousands of instances for something that needs to be processed every frame can be a bottleneck.

This type of situation makes programmers regret they are using a game engine and wish they could go
back to a more handcrafted, low level implementation of game code.

Still, Pandemonium is designed to work around this problem.

## Servers

One of the most interesting design decisions for Pandemonium is the fact that the whole scene system is
*optional*. While it is not currently possible to compile it out, it can be completely bypassed.

At the core, Pandemonium uses the concept of Servers. They are very low-level APIs to control
rendering, physics, sound, etc. The scene system is built on top of them and uses them directly.
The most common servers are:

* `RenderingServer`: handles everything related to graphics.
* `PhysicsServer`: handles everything related to 3D physics.
* `Physics2DServer`: handles everything related to 2D physics.
* `AudioServer`: handles everything related to audio.
* `NavigationServer`: handles everything related to 3D navigation.
* `Navigation2DServer`: handles everything related to 2D navigation.

Explore their APIs and you will realize that all the functions provided are low-level
implementations of everything Pandemonium allows you to do.

## RIDs

The key to using servers is understanding Resource ID (`RID`) objects. These are opaque
handles to the server implementation. They are allocated and freed manually. Almost every
function in the servers requires RIDs to access the actual resource.

Most Pandemonium nodes and resources contain these RIDs from the servers internally, and they can
be obtained with different functions. In fact, anything that inherits `Resource`
can be directly casted to an RID. Not all resources contain an RID, though: in such cases, the RID will be empty. The resource can then be passed to server APIs as an RID.

Warning: Resources are reference-counted (see `Reference`), and
references to a resource's RID are *not* counted when determining whether
the resource is still in use. Make sure to keep a reference to the resource
outside the server, or else both it and its RID will be erased.

For nodes, there are many functions available:

* For CanvasItem, the `CanvasItem.get_canvas_item()`
  method will return the canvas item RID in the server.
* For CanvasLayer, the `CanvasLayer.get_canvas()`
  method will return the canvas RID in the server.
* For Viewport, the `Viewport.get_viewport_rid()`
  method will return the viewport RID in the server.
* For 3D, the `World`
  and `Spatial` nodes)
  contains functions to get the *VisualServer Scenario*, and the *PhysicsServer Space*. This
  allows creating 3D objects directly with the server API and using them.
* For 2D, the `World2D`
  and `CanvasItem` nodes)
  contains functions to get the *VisualServer Canvas*, and the *Physics2DServer Space*. This
  allows creating 2D objects directly with the server API and using them.
* The `VisualInstance` class, allows getting the scenario *instance* and
  *instance base* via the `VisualInstance.get_instance()`
  and `VisualInstance.get_base()` respectively.

Try exploring the nodes and resources you are familiar with and find the functions to obtain the server *RIDs*.

It is not advised to control RIDs from objects that already have a node associated. Instead, server
functions should always be used for creating and controlling new ones and interacting with the existing ones.

## Creating a sprite

This is a simple example of how to create a sprite from code and move it using the low-level
`CanvasItem` API.


```
extends Node2D


# VisualServer expects references to be kept around.
var texture


func _ready():
    # Create a canvas item, child of this node.
    var ci_rid = VisualServer.canvas_item_create()
    # Make this node the parent.
    VisualServer.canvas_item_set_parent(ci_rid, get_canvas_item())
    # Draw a texture on it.
    # Remember, keep this reference.
    texture = load("res://my_texture.png)")
    # Add it, centered.
    VisualServer.canvas_item_add_texture_rect(ci_rid, Rect2(texture.get_size() / 2, texture.get_size()), texture)
    # Add the item, rotated 45 degrees and translated.
    var xform = Transform2D().rotated(deg2rad(45)).translated(Vector2(20, 30))
    VisualServer.canvas_item_set_transform(ci_rid, xform)
```

The Canvas Item API in the server allows you to add draw primitives to it. Once added, they can't be modified.
The Item needs to be cleared and the primitives re-added (this is not the case for setting the transform,
which can be done as many times as desired).

Primitives are cleared this way:

```
VisualServer.canvas_item_clear(ci_rid)
```

## Instantiating a Mesh into 3D space

The 3D APIs are different from the 2D ones, so the instantiation API must be used.

```
extends Spatial


# VisualServer expects references to be kept around.
var mesh


func _ready():
    # Create a visual instance (for 3D).
    var instance = VisualServer.instance_create()
    # Set the scenario from the world, this ensures it
    # appears with the same objects as the scene.
    var scenario = get_world().scenario
    VisualServer.instance_set_scenario(instance, scenario)
    # Add a mesh to it.
    # Remember, keep the reference.
    mesh = load("res://mymesh.obj")
    VisualServer.instance_set_base(instance, mesh)
    # Move the mesh around.
    var xform = Transform(Basis(), Vector3(20, 100, 0))
    VisualServer.instance_set_transform(instance, xform)
```

## Creating a 2D RigidBody and moving a sprite with it

This creates a `RigidBody2D` API,
and moves a `CanvasItem` when the body moves.

```
# Physics2DServer expects references to be kept around.
var body
var shape


func _body_moved(state, index):
    # Created your own canvas item, use it here.
    VisualServer.canvas_item_set_transform(canvas_item, state.transform)


func _ready():
    # Create the body.
    body = Physics2DServer.body_create()
    Physics2DServer.body_set_mode(body, Physics2DServer.BODY_MODE_RIGID)
    # Add a shape.
    shape = Physics2DServer.rectangle_shape_create()
    # Set rectangle extents.
    Physics2DServer.shape_set_data(shape, Vector2(10, 10))
    # Make sure to keep the shape reference!
    Physics2DServer.body_add_shape(body, shape)
    # Set space, so it collides in the same space as current scene.
    Physics2DServer.body_set_space(body, get_world_2d().space)
    # Move initial position.
    Physics2DServer.body_set_state(body, Physics2DServer.BODY_STATE_TRANSFORM, Transform2D(0, Vector2(10, 20)))
    # Add the transform callback, when body moves
    # The last parameter is optional, can be used as index
    # if you have many bodies and a single callback.
    Physics2DServer.body_set_force_integration_callback(body, self, "_body_moved", 0)
```

The 3D version should be very similar, as 2D and 3D physics servers are identical (using
`RigidBody` respectively).

## Getting data from the servers

Try to **never** request any information from `VisualServer`, `PhysicsServer` or `Physics2DServer`
by calling functions unless you know what you are doing. These servers will often run asynchronously
for performance and calling any function that returns a value will stall them and force them to process
anything pending until the function is actually called. This will severely decrease performance if you
call them every frame (and it won't be obvious why).

Because of this, most APIs in such servers are designed so it's not even possible to request information
back, until it's actual data that can be saved.

