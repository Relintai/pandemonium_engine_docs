
# Optimizing 3D performance

# Culling

Pandemonium will automatically perform view frustum culling in order to prevent
rendering objects that are outside the viewport. This works well for games that
take place in a small area, however things can quickly become problematic in
larger levels.

### Occlusion culling

Walking around a town for example, you may only be able to see a few buildings
in the street you are in, as well as the sky and a few birds flying overhead. As
far as a naive renderer is concerned however, you can still see the entire town.
It won't just render the buildings in front of you, it will render the street
behind that, with the people on that street, the buildings behind that. You
quickly end up in situations where you are attempting to render 10× or 100× more
than what is visible.

Things aren't quite as bad as they seem, because the Z-buffer usually allows the
GPU to only fully shade the objects that are at the front. This is called *depth
prepass* and is enabled by default in Pandemonium when using the GLES3 renderer.
However, unneeded objects are still reducing performance.

One way we can potentially reduce the amount to be rendered is to take advantage
of occlusion.

For instance, in our city street scenario, you may be able to work out in advance
that you can only see two other streets, `B` and `C`, from street `A`.
Streets `D` to `Z` are hidden. In order to take advantage of occlusion, all
you have to do is work out when your viewer is in street `A` (perhaps using
Pandemonium Areas), then you can hide the other streets.

This example is a manual version of what is known as a *potentially visible set*.
It is a very powerful technique for speeding up rendering. You can also use it to
restrict physics or AI to the local area, and speed these up as well as
rendering.

### Portal Rendering

However, there is a much easier way to take advantage of occlusion. Pandemonium features
an advanced portal rendering system, which can perform occlusion culling from cameras and
lights.

This is not a fully automatic system and it requires some manual setup. However, it potentially
offers significant performance increases.

Note: In some cases, you can adapt your level design to add more occlusion
opportunities. For example, you can add more walls to prevent the player
from seeing too far away, which would decrease performance due to the lost
opportunies for occlusion culling.

### Other occlusion techniques

As well as the portal system and manual methods, there are various other occlusion
techniques such as raster-based occlusion culling. Some of these may be available
through add-ons or may be available in core Pandemonium in the future.

### Transparent objects

Pandemonium sorts objects by `Material` and `Shader`
to improve performance. This, however, can not be done with
transparent objects. Transparent objects are rendered from back to front to make
blending with what is behind work. As a result,
**try to use as few transparent objects as possible**. If an object has a
small section with transparency, try to make that section a separate surface
with its own material.

# Level of detail (LOD)

In some situations, particularly at a distance, it can be a good idea to
**replace complex geometry with simpler versions**. The end user will probably
not be able to see much difference. Consider looking at a large number of trees
in the far distance. There are several strategies for replacing models at
varying distance. You could use lower poly models, or use transparency to
simulate more complex geometry.

### Billboards and imposters

The simplest version of using transparency to deal with LOD is billboards. For
example, you can use a single transparent quad to represent a tree at distance.
This can be very cheap to render, unless of course, there are many trees in
front of each other. In which case transparency may start eating into fill rate.

An alternative is to render not just one tree, but a number of trees together as
a group. This can be especially effective if you can see an area but cannot
physically approach it in a game.

You can make imposters by pre-rendering views of an object at different angles.
Or you can even go one step further, and periodically re-render a view of an
object onto a texture to be used as an imposter. At a distance, you need to move
the viewer a considerable distance for the angle of view to change
significantly. This can be complex to get working, but may be worth it depending
on the type of project you are making.

### Use instancing (MultiMesh)

If several identical objects have to be drawn in the same place or nearby, try
using `MultiMesh` instead. MultiMesh allows the drawing
of many thousands of objects at very little performance cost, making it ideal
for flocks, grass, particles, and anything else where you have thousands of
identical objects.

# Bake lighting

Lighting objects is one of the most costly rendering operations. Realtime
lighting, shadows (especially multiple lights), and GI are especially expensive.
They may simply be too much for lower power mobile devices to handle.

**Consider using baked lighting**, especially for mobile. This can look fantastic,
but has the downside that it will not be dynamic. Sometimes, this is a trade-off
worth making.

In general, if several lights need to affect a scene, it's best to use
baked lightmaps. Baking can also improve the scene quality by adding
indirect light bounces.

# Animation and skinning

Animation and vertex animation such as skinning and morphing can be very
expensive on some platforms. You may need to lower the polycount considerably
for animated models or limit the number of them on screen at any one time.

# Large worlds

If you are making large worlds, there are different considerations than what you
may be familiar with from smaller games.

Large worlds may need to be built in tiles that can be loaded on demand as you
move around the world. This can prevent memory use from getting out of hand, and
also limit the processing needed to the local area.

There may also be rendering and physics glitches due to floating point error in
large worlds. You may be able to use techniques such as orienting the world
around the player (rather than the other way around), or shifting the origin
periodically to keep things centred around `Vector3(0, 0, 0)`.

