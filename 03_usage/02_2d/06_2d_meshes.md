
# 2D meshes

## Introduction

In 3D, meshes are used to display the world. In 2D, they are rare as images are used more often.
Pandemonium's 2D engine is a pure two-dimensional engine, so it can't really display 3D meshes directly (although it can be done
via `Viewport` and `ViewportTexture`).

2D meshes are meshes that contain two-dimensional geometry (Z can be omitted or ignored) instead of 3D.
You can experiment creating them yourself using `SurfaceTool` from code and displaying them in a `MeshInstance2D` node.

Currently, the only way to generate a 2D mesh within the editor is by either importing an OBJ file as a mesh, or converting it from a Sprite.

## Optimizing pixels drawn

This workflow is useful for optimizing 2D drawing in some situations. When drawing large images with transparency, Pandemonium will draw the whole quad to the screen. The large transparent areas will still be drawn.

This can affect performance, especially on mobile devices, when drawing very large images (generally screen sized),
or layering multiple images on top of each other with large transparent areas (for example, when using `ParallaxBackground`).

Converting to a mesh will ensure that only the opaque parts will be drawn and the rest will be ignored.

## Converting Sprites to 2D meshes

You can take advantage of this optimization by converting a `Sprite` to a `MeshInstance2D`.
Start with an image that contains large amounts of transparency on the edges, like this tree:

![](img/mesh2d1.png)

Put it in a `Sprite` and select "Convert to 2D Mesh" from the menu:

![](img/mesh2d2.png)

A dialog will appear, showing a preview of how the 2D mesh will be created:

![](img/mesh2d3.png)

The default values are good enough for many cases, but you can change growth and simplification according to your needs:

![](img/mesh2d4.png)

Finally, push the `Convert 2D Mesh` button and your Sprite will be replaced:

![](img/mesh2d5.png)

