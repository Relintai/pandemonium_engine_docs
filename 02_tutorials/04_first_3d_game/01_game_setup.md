
# Setting up the game area

In this first part, we're going to set up the game area. Let's get started by
importing the start assets and setting up the game scene.

We've prepared a Pandemonium project with the 3D models and sounds we'll use for this
tutorial, linked in the index page. If you haven't done so yet, you can download
the archive here: [Squash the Creeps assets](files/squash_the_creeps.zip).

Once you downloaded it, extract the .zip archive on your computer. Open the
Pandemonium project manager and click the *Import* button.

![](img/01.game_setup/01.import_button.png)

In the import popup, enter the full path to the freshly created directory
`squash_the_creeps/`. You can click the *Browse* button on the right to
open a file browser and navigate to the `project.pandemonium` file the folder
contains.

![](img/01.game_setup/02.browse_to_project_folder.png)

Click *Import & Edit* to open the project in the editor.

![](img/01.game_setup/03.import_and_edit.png)

The start project contains an icon and two folders: `art/` and `fonts/`.
There, you will find the art assets and music we'll use in the game.

![](img/01.game_setup/04.start_assets.png)

There are two 3D models, `player.glb` and `mob.glb`, some materials that
belong to these models, and a music track.

## Setting up the playable area

We're going to create our main scene with a plain *Node* as its root. In the
*Scene* dock, click the *Add Node* button represented by a "+" icon in the
top-left and double-click on *Node*. Name the node "Main". Alternatively, to add
a node to the scene, you can press `Ctrl + a` (or `Cmd + a` on macOS).

![](img/01.game_setup/05.main_node.png)

Save the scene as `Main.tscn` by pressing `Ctrl + s` (`Cmd + s` on macOS).

We'll start by adding a floor that'll prevent the characters from falling. To
create static colliders like the floor, walls, or ceilings, you can use
*StaticBody* nodes. They require *CollisionShape* child nodes to
define the collision area. With the *Main* node selected, add a *StaticBody*
node, then a *CollisionShape*. Rename the *StaticBody* as *Ground*.

![](img/01.game_setup/06.staticbody_node.png)

A warning sign next to the *CollisionShape* appears because we haven't defined
its shape. If you click the icon, a popup appears to give you more information.

![](img/01.game_setup/07.collision_shape_warning.png)

To create a shape, with the *CollisionShape* selected, head to the *Inspector*
and click the *[empty]* field next to the *Shape* property. Create a new *Box
Shape*.

![](img/01.game_setup/08.create_box_shape.png)

The box shape is perfect for flat ground and walls. Its thickness makes it
reliable to block even fast-moving objects.

A box's wireframe appears in the viewport with three orange dots. You can click
and drag these to edit the shape's extents interactively. We can also precisely
set the size in the inspector. Click on the *BoxShape* to expand the resource.
Set its *Extents* to `30` on the X axis, `1` for the Y axis, and `30` for
the Z axis.

![](img/01.game_setup/09.box_extents.png)

Note: In 3D, translation and size units are in meters. The box's total size is
twice its extents: `60` by `60` meters on the ground plane and `2`
units tall. The ground plane is defined by the X and Z axes, while the Y
axis represents the height.

Collision shapes are invisible. We need to add a visual floor that goes along
with it. Select the *Ground* node and add a *MeshInstance* as its child.

![](img/01.game_setup/10.mesh_instance.png)

In the *Inspector*, click on the field next to *Mesh* and create a *CubeMesh*
resource to create a visible cube.

![](img/01.game_setup/11.cube_mesh.png)

Once again, it's too small by default. Click the cube icon to expand the
resource and set its *Size* to `60`, `2`, and `60`. As the cube
resource works with a size rather than extents, we need to use these values so
it matches our collision shape.

![](img/01.game_setup/12.cube_resized.png)

You should see a wide grey slab that covers the grid and blue and red axes in
the viewport.

We're going to move the ground down so we can see the floor grid. Select the
*Ground* node, hold the `Ctrl` key down to turn on grid snapping (`Cmd` on macOS),
and click and drag down on the Y axis. It's the green arrow in the move gizmo.

![](img/01.game_setup/13.move_gizmo_y_axis.png)

Note: If you can't see the 3D object manipulator like on the image above, ensure
the *Select Mode* is active in the toolbar above the view.

![](img/01.game_setup/14.select_mode_icon.png)

Move the ground down `1` meter. A label in the bottom-left corner of the
viewport tells you how much you're translating the node.

![](img/01.game_setup/15.translation_amount.png)

Note: Moving the *Ground* node down moves both children along with it.
Ensure you move the *Ground* node, **not** the *MeshInstance* or the
*CollisionShape*.

Let's add a directional light so our scene isn't all grey. Select the *Main*
node and add a *DirectionalLight* as a child of it. We need to move it and
rotate it. Move it up by clicking and dragging on the manipulator's green arrow
and click and drag on the red arc to rotate it around the X axis, until the
ground is lit.

In the *Inspector*, turn on *Shadow -&gt; Enabled* by clicking the checkbox.

![](img/01.game_setup/16.turn_on_shadows.png)

At this point, your project should look like this.

![](img/01.game_setup/17.project_with_light.png)

That's our starting point. In the next part, we will work on the player scene
and base movement.

