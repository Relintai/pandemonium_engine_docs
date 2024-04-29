

# Ray-casting

## Introduction

One of the most common tasks in game development is casting a ray (or
custom shaped object) and checking what it hits. This enables complex
behaviors, AI, etc. to take place. This tutorial will explain how to
do this in 2D and 3D.

Pandemonium stores all the low level game information in servers, while the
scene is just a frontend. As such, ray casting is generally a
lower-level task. For simple raycasts, node such as
`RayCast`
will work, as they will return every frame what the result of a raycast
is.

Many times, though, ray-casting needs to be a more interactive process
so a way to do this by code must exist.

## Space

In the physics world, Pandemonium stores all the low level collision and
physics information in a *space*. The current 2d space (for 2D Physics)
can be obtained by accessing
`CanvasItem.get_world_2d().space`.
For 3D, it's `Spatial.get_world().space`.

The resulting space `RID` can be used in
`PhysicsServer` and
`Physics2DServer` respectively for 3D and 2D.

## Accessing space

Pandemonium physics runs by default in the same thread as game logic, but may
be set to run on a separate thread to work more efficiently. Due to
this, the only time accessing space is safe is during the
`Node._physics_process()`
callback. Accessing it from outside this function may result in an error
due to space being *locked*.

To perform queries into physics space, the
`Physics2DDirectSpaceState`
and `PhysicsDirectSpaceState`
must be used.

Use the following code in 2D:

gdscript GDscript

```
    func _physics_process(delta):
        var space_rid = get_world_2d().space
        var space_state = Physics2DServer.space_get_direct_state(space_rid)
```

Or more directly:

gdscript GDScript

```
    func _physics_process(delta):
        var space_state = get_world_2d().direct_space_state
```

And in 3D:

gdscript GDScript

```
    func _physics_process(delta):
        var space_state = get_world().direct_space_state
```

## Raycast query

For performing a 2D raycast query, the method
`Physics2DDirectSpaceState.intersect_ray()`
may be used. For example:

gdscript GDScript

```
    func _physics_process(delta):
        var space_state = get_world_2d().direct_space_state
        # use global coordinates, not local to node
        var result = space_state.intersect_ray(Vector2(0, 0), Vector2(50, 100))
```

The result is a dictionary. If the ray didn't hit anything, the dictionary will
be empty. If it did hit something, it will contain collision information:

gdscript GDScript

```
        if result:
            print("Hit at point: ", result.position)
```

The `result` dictionary when a collision occurs contains the following
data:

```
    {
       position: Vector2 # point in world space for collision
       normal: Vector2 # normal in world space for collision
       collider: Object # Object collided or null (if unassociated)
       collider_id: ObjectID # Object it collided against
       rid: RID # RID it collided against
       shape: int # shape index of collider
       metadata: Variant() # metadata of collider
    }
```

The data is similar in 3D space, using Vector3 coordinates.

## Collision exceptions

A common use case for ray casting is to enable a character to gather data
about the world around it. One problem with this is that the same character
has a collider, so the ray will only detect its parent's collider,
as shown in the following image:

![](img/raycast_falsepositive.png)

To avoid self-intersection, the `intersect_ray()` function can take an
optional third parameter which is an array of exceptions. This is an
example of how to use it from a KinematicBody2D or any other
collision object node:

gdscript GDScript

```
    extends KinematicBody2D

    func _physics_process(delta):
        var space_state = get_world_2d().direct_space_state
        var result = space_state.intersect_ray(global_position, enemy_position, [self])
```

The exceptions array can contain objects or RIDs.

## Collision Mask

While the exceptions method works fine for excluding the parent body, it becomes
very inconvenient if you need a large and/or dynamic list of exceptions. In
this case, it is much more efficient to use the collision layer/mask system.

The optional fourth argument for `intersect_ray()` is a collision mask. For
example, to use the same mask as the parent body, use the `collision_mask`
member variable:

gdscript GDScript

```
    extends KinematicBody2D

    func _physics_process(delta):
        var space_state = get_world().direct_space_state
        var result = space_state.intersect_ray(global_position, enemy_position,
                                [self], collision_mask)
```

See `doc_physics_introduction_collision_layer_code_example` for details on how to set the collision mask.

## 3D ray casting from screen

Casting a ray from screen to 3D physics space is useful for object
picking. There is not much need to do this because
`CollisionObject`
has an "input_event" signal that will let you know when it was clicked,
but in case there is any desire to do it manually, here's how.

To cast a ray from the screen, you need a `Camera`
node. A `Camera` can be in two projection modes: perspective and
orthogonal. Because of this, both the ray origin and direction must be
obtained. This is because `origin` changes in orthogonal mode, while
`normal` changes in perspective mode:

![](img/raycast_projection.png)

To obtain it using a camera, the following code can be used:

gdscript GDScript

```
    const ray_length = 1000

    func _input(event):
        if event is InputEventMouseButton and event.pressed and event.button_index == 1:
              var camera = $Camera
              var from = camera.project_ray_origin(event.position)
              var to = from + camera.project_ray_normal(event.position) * ray_length
```


Remember that during `input()`, the space may be locked, so in practice
this query should be run in `physics_process()`.
