

Using RigidBody
===============

What is a rigid body?
---------------------

A rigid body is one that is directly controlled by the physics engine in order to simulate the behavior of physical objects.
In order to define the shape of the body, it must have one or more `Shape` objects assigned. Note that setting the position of these shapes will affect the body's center of mass.

How to control a rigid body
---------------------------

A rigid body's behavior can be altered by setting its properties, such as mass and weight.
A physics material needs to be added to the rigid body to adjust its friction and bounce,
and set if it's absorbent and/or rough. These properties can be set in the Inspector or via code.
See `RigidBody` for
the full list of properties and their effects.

There are several ways to control a rigid body's movement, depending on your desired application.

If you only need to place a rigid body once, for example to set its initial location, you can use the methods provided by the `Spatial` node, such as `set_global_transform()` or `look_at()`. However, these methods cannot be called every frame or the physics engine will not be able to correctly simulate the body's state.
As an example, consider a rigid body that you want to rotate so that it points towards another object. A common mistake when implementing this kind of behavior is to use `look_at()` every frame, which breaks the physics simulation. Below, we'll demonstrate how to implement this correctly.

The fact that you can't use `set_global_transform()` or `look_at()` methods doesn't mean that you can't have full control of a rigid body. Instead, you can control it by using the `integrate_forces()` callback. In this method, you can add *forces*, apply *impulses*, or set the *velocity* in order to achieve any movement you desire.

The "look at" method
--------------------

As described above, using the Spatial node's `look_at()` method can't be used each frame to follow a target.
Here is a custom `look_at()` method that will work reliably with rigid bodies:

gdscript GDScript

```
    extends RigidBody

    func look_follow(state, current_transform, target_position):
        var up_dir = Vector3(0, 1, 0)
        var cur_dir = current_transform.basis.xform(Vector3(0, 0, 1))
        var target_dir = (target_position - current_transform.origin).normalized()
        var rotation_angle = acos(cur_dir.x) - acos(target_dir.x)

        state.set_angular_velocity(up_dir * (rotation_angle / state.get_step()))

    func _integrate_forces(state):
        var target_position = $my_target_spatial_node.get_global_transform().origin
        look_follow(state, get_global_transform(), target_position)
```


This method uses the rigid body's `set_angular_velocity()` method to rotate the body. It first calculates the difference between the current and desired angle and then adds the velocity needed to rotate by that amount in one frame's time.

Note:
 This script will not work with rigid bodies in *character mode* because then, the body's rotation is locked. In that case, you would have to rotate the attached mesh node instead using the standard Spatial methods.
