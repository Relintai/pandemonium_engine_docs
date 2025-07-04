
# Multiple resolutions

## The problem of multiple resolutions

Developers often have trouble understanding how to best support multiple
resolutions in their games. For desktop and console games, this is more or less
straightforward, as most screen aspect ratios are 16:9 and resolutions
are standard (720p, 1080p, 1440p, 4K, …).

For mobile games, at first, it was easy. For many years, the iPhone and iPad
used the same resolution. When *Retina* was implemented, they just doubled
the pixel density; most developers had to supply assets in default and double
resolutions.

Nowadays, this is no longer the case, as there are plenty of different screen
sizes, densities, and aspect ratios. Non-conventional sizes are also becoming
increasingly popular, such as ultrawide displays.

For 3D games, there is not much of a need to support multiple resolutions (from
the aesthetic point of view). The 3D geometry will just fill the screen based on
the field of view, disregarding the aspect ratio. The main reason one may want
to support this, in this case, is for *performance* reasons (running in lower
resolution to increase frames per second).

For 2D and game UIs, this is a different matter, as art needs to be created
using specific pixel sizes in software such as Photoshop, GIMP or Krita.

Since layouts, aspect ratios, resolutions, and pixel densities can change so
much, it is no longer possible to design UIs for every specific screen.
Another method must be used.

## One size fits all

The most common approach is to use a single *base* resolution and
then fit it to everything else. This resolution is how most players are expected
to play the game (given their hardware). For mobile, Google has useful
[stats](https://developer.android.com/about/dashboards) online, and for desktop,
Steam [also does](https://store.steampowered.com/hwsurvey/).

As an example, Steam shows that the most common *primary display resolution* is
1920×1080, so a sensible approach is to develop a game for this resolution, then
handle scaling for different sizes and aspect ratios.

Pandemonium provides several useful tools to do this easily.

## Base size

A base size for the window can be specified in the Project Settings under
**Display → Window**.

![](img/screenres.png)

However, what it does is not completely obvious; the engine will *not*
attempt to switch the monitor to this resolution. Rather, think of this
setting as the "design size", i.e. the size of the area that you work
with in the editor. This setting corresponds directly to the size of the
blue rectangle in the 2D editor.

There is often a need to support devices with screen and window sizes
that are different from this base size. Pandemonium offers many ways to
control how the viewport will be resized and stretched to different
screen sizes.

### Note:

Pandemonium follows a modern approach to multiple resolutions. The engine will
never change the monitor's resolution on its own. While changing the
monitor's resolution is the most efficient approach, it's also the least
reliable approach as it can leave the monitor stuck on a low resolution if
the game crashes. This is especially common on macOS or Linux which don't
handle resolution changes as well as Windows.

Changing the monitor's resolution also removes any control from the game
developer over filtering and aspect ratio stretching, which can be important
to ensure correct display for pixel art games.

On top of that, changing the monitor's resolution makes alt-tabbing in and
out of a game much slower since the monitor has to change resolutions every
time this is done.

## Resizing

There are several types of devices, with several types of screens, which
in turn have different pixel density and resolutions. Handling all of
them can be a lot of work, so Pandemonium tries to make the developer's life a
little easier. The `Viewport`
node has several functions to handle resizing, and the root node of the
scene tree is always a viewport (scenes loaded are instanced as a child
of it, and it can always be accessed by calling
`get_tree().get_root()` or `get_node("/root")`).

In any case, while changing the root Viewport params is probably the
most flexible way to deal with the problem, it can be a lot of work,
code and guessing, so Pandemonium provides a simple set of parameters in the
project settings to handle multiple resolutions.

## Stretch settings

Stretch settings are located in the project settings and provide several options:

![](img/stretchsettings.png)

#### Stretch Mode

The **Stretch Mode** setting defines how the base size is stretched to fit
the resolution of the window or screen.

![](img/stretch.png)

The animations below use a "base size" of just 16×9 pixels to
demonstrate the effect of different stretch modes. A single sprite, also
16×9 pixels in size, covers the entire viewport, and a diagonal
`Line2D` is added on top of it:

![](img/stretch_demo_scene.png)

Animated GIFs are generated from: https://github.com/ttencate/godot_scaling_mode

-  **Stretch Mode = Disabled** (default): No stretching happens. One
   unit in the scene corresponds to one pixel on the screen. In this
   mode, the **Stretch Aspect** setting has no effect.

   ![](img/stretch_disabled_expand.gif)

-  **Stretch Mode = 2D**: In this mode, the base size specified in
   width and height in the project settings is
   stretched to cover the whole screen (taking the **Stretch Aspect**
   setting into account). This means that everything is rendered
   directly at the target resolution. 3D is unaffected,
   while in 2D, there is no longer a 1:1 correspondence between sprite
   pixels and screen pixels, which may result in scaling artifacts.

   ![](img/stretch_2d_expand.gif)

-  **Stretch Mode = Viewport**: Viewport scaling means that the size of
   the root `Viewport` is set precisely to the
   base size specified in the Project Settings' **Display** section.
   The scene is rendered to this viewport first. Finally, this viewport
   is scaled to fit the screen (taking the **Stretch Aspect** setting into
   account).

   ![](img/stretch_viewport_expand.gif)

#### Stretch Aspect

The second setting is the stretch aspect. Note that this only takes effect if
**Stretch Mode** is set to something other than **Disabled**.

In the animations below, you will notice gray and black areas. The black
areas are added by the engine and cannot be drawn into. The gray areas
are part of your scene, and can be drawn to. The gray areas correspond
to the region outside the blue frame you see in the 2D editor.

-  **Stretch Aspect = Ignore**: Ignore the aspect ratio when stretching
   the screen. This means that the original resolution will be stretched
   to exactly fill the screen, even if it's wider or narrower. This may
   result in nonuniform stretching: things looking wider or taller than
   designed.

   ![](img/stretch_viewport_ignore.gif)

-  **Stretch Aspect = Keep**: Keep aspect ratio when stretching the
   screen. This means that the viewport retains its original size
   regardless of the screen resolution, and black bars will be added to
   the top/bottom of the screen ("letterboxing") or the sides
   ("pillarboxing").

   This is a good option if you know the aspect ratio of your target
   devices in advance, or if you don't want to handle different aspect
   ratios.

   ![](img/stretch_viewport_keep.gif)

-  **Stretch Aspect = Keep Width**: Keep aspect ratio when stretching the
   screen. If the screen is wider than the base size, black bars are
   added at the left and right (pillarboxing). But if the screen is
   taller than the base resolution, the viewport will be grown in the
   vertical direction (and more content will be visible to the bottom).
   You can also think of this as "Expand Vertically".

   This is usually the best option for creating GUIs or HUDs that scale,
   so some controls can be anchored to the bottom.

   ![](img/stretch_viewport_keep_width.gif)

-  **Stretch Aspect = Keep Height**: Keep aspect ratio when stretching
   the screen. If the screen is taller than the base size, black
   bars are added at the top and bottom (letterboxing). But if the
   screen is wider than the base resolution, the viewport will be grown
   in the horizontal direction (and more content will be visible to the
   right). You can also think of this as "Expand Horizontally".

   This is usually the best option for 2D games that scroll horizontally
   (like runners or platformers).

   ![](img/stretch_viewport_keep_height.gif)

-  **Stretch Aspect = Expand**: Keep aspect ratio when stretching the
   screen, but keep neither the base width nor height. Depending on the
   screen aspect ratio, the viewport will either be larger in the
   horizontal direction (if the screen is wider than the base size) or
   in the vertical direction (if the screen is taller than the original
   size).

   ![](img/stretch_viewport_expand.gif)

Tip:

To support both portrait and landscape mode with a similar automatically
determined scale factor, set your project's base resolution to be a *square*
(1:1 aspect ratio) instead of a rectangle. For instance, if you wish to design
for 1280×720 as the base resolution but wish to support both portrait and
landscape mode, use 720×720 as the project's base window size in the
Project Settings.

To allow the user to choose their preferred screen orientation at run-time,
remember to set **Display > Window > Handheld > Orientation** to `sensor`.

#### Stretch Shrink

The **Shrink** setting allows you to add an extra scaling factor on top of
what the **Stretch** options above already provide. The default value of 1
means that no scaling occurs.

If, for example, you set **Shrink** to 4 and leave **Stretch Mode** on
**Disabled**, each unit in your scene will correspond to 4×4 pixels on the
screen.

If **Stretch Mode** is set to something other than **Disabled**, the size of
the root viewport is scaled down by the **Shrink** factor, and pixels
in the output are scaled up by the same amount. This is rarely useful for
2D games, but can be used to increase performance in 3D games
by rendering them at a lower resolution.

#### From scripts

To configure stretching at runtime from a script, use the
`get_tree().set_screen_stretch()` method (see
`SceneTree.set_screen_stretch()`).

## Common use case scenarios

The following settings are recommended to support multiple resolutions and aspect
ratios well.

#### Desktop game

**Non-pixel art:**

- Set the base window width to `1920` and window height to `1080`. If you have a
  display smaller than 1920×1080, set **Test Width** and **Test Height** to
  lower values to make the window smaller when the project starts.
- Alternatively, if you're targeting high-end devices primarily, set the base
  window width to `3840` and window height to `2160`.
  This allows you to provide higher resolution 2D assets, resulting in crisper
  visuals at the cost of higher memory usage and file sizes.
  Note that this will make non-mipmapped textures grainy on low resolution devices.
- Set the stretch mode to `2d`.
- Set the stretch aspect to `expand`. This allows for supporting multiple aspect ratios
  and makes better use of tall smartphone displays (such as 18:9 or 19:9 aspect ratios).
- Configure Control nodes' anchors to snap to the correct corners using the **Layout** menu.

**Pixel art:**

- Set the base window size to the viewport size you intend to use. Most pixel art games
  use viewport sizes between 256×224 and 640×480. Higher viewport sizes will
  require using higher resolution artwork, unless you intend to show more of the
  game world at a given time.
- Set the stretch mode to `viewport`.
- Set the stretch aspect to `keep` to enforce a single aspect ratio (with
  black bars). As an alternative, you can set the stretch aspect to `expand` to
  support multiple aspect ratios.
- If using the `expand` stretch aspect, Configure Control nodes' anchors to
  snap to the correct corners using the **Layout** menu.

Note:

The `viewport` stretch mode provides low-resolution rendering that is then
stretched to the final window size. If you are OK with sprites being able to
move or rotate in "sub-pixel" positions or wish to have a high resolution 3D
viewport, you should use the `2d` stretch mode instead of the `viewport`
stretch mode.

Pandemonium currently doesn't have a way to enforce integer scaling when using the
`2d` or `viewport` stretch mode, which means pixel art may look bad if the
final window size is not a multiple of the base window size.
To fix this, use an add-on such as
the [Integer Resolution Handler](https://github.com/Yukitty/pandemonium-addon-integer_resolution_handler).

#### Mobile game in landscape mode

Pandemonium is configured to use landscape mode by default. This means you don't need
to change the display orientation project setting.

- Set the base window width to `1280` and window height to `720`.
- Alternatively, if you're targeting high-end devices primarily, set the base
  window width to `1920` and window height to `1080`.
  This allows you to provide higher resolution 2D assets, resulting in crisper
  visuals at the cost of higher memory usage and file sizes. Many devices have
  even higher resolution displays (1440p), but the difference with 1080p is
  barely visible given the small size of smartphone displays.
  Note that this will make non-mipmapped textures grainy on low resolution devices.
- Set the stretch mode to `2d`.
- Set the stretch aspect to `expand`. This allows for supporting multiple aspect ratios
  and makes better use of tall smartphone displays (such as 18:9 or 19:9 aspect ratios).
- Configure Control nodes' anchors to snap to the correct corners using the **Layout** menu.

#### Mobile game in portrait mode

- Set the base window width to `720` and window height to `1080`.
- Alternatively, if you're targeting high-end devices primarily, set the base
  window width to `1080` and window height to `1920`.
  This allows you to provide higher resolution 2D assets, resulting in crisper
  visuals at the cost of higher memory usage and file sizes. Many devices have
  even higher resolution displays (1440p), but the difference with 1080p is
  barely visible given the small size of smartphone displays.
  Note that this will make non-mipmapped textures grainy on low resolution devices.
- Set **Display &gt; Window &gt; Handheld &gt; Orientation** to `portrait`.
- Set the stretch mode to `2d`.
- Set the stretch aspect to `expand`. This allows for supporting multiple aspect ratios
  and makes better use of tall smartphone displays (such as 18:9 or 19:9 aspect ratios).
- Configure Control nodes' anchors to snap to the correct corners using the **Layout** menu.

#### Non-game application

- Set the base window width and height to the smallest window size that you intend to target.
  This is not required, but this ensures that you design your UI with small window sizes in mind.
- Keep the stretch mode to its default value, `disabled`.
- Keep the stretch aspect to its default value, `ignore`
  (its value won't be used since the stretch mode is `disabled`).
- You can define a minimum window size by setting `OS.min_window_size` in a
  script's `ready()` function. This prevents the user from resizing the application
  below a certain size, which could break the UI layout.

Note:

Pandemonium doesn't support manually overriding the 2D scale factor yet, so it is
not possible to have hiDPI support in non-game applications. Due to this, it
is recommended to leave **Allow Hidpi** disabled in non-game applications to
allow for the OS to use its low-DPI fallback.

## hiDPI support

By default, Pandemonium projects aren't considered DPI-aware by the operating system.
This is done to improve performance on low-end systems, since the operating
system's DPI fallback scaling will be faster than letting the application scale
itself (even when using the `viewport` stretch mode).

However, the OS-provided DPI fallback scaling doesn't play well with fullscreen
mode. If you want crisp visuals on hiDPI displays or if project uses fullscreen,
it's recommended to enable **Display &gt; Window &gt; Dpi &gt; Allow Hidpi** in the
Project Settings.

**Allow Hidpi** is only effective on Windows and macOS. It's ignored on all
other platforms.

Note:

The Pandemonium editor itself is always marked as DPI-aware. Running the project
from the editor will only be DPI-aware if **Allow Hidpi** is enabled in the
Project Settings.

## Reducing aliasing on downsampling

If the game has a very high base resolution (e.g. 3840×2160), aliasing might
appear when downsampling to something considerably lower like 1280×720.
Aliasing can be made less visible by shrinking all images by a factor of 2
upon loading. This can be done by calling the method below before
the game data is loaded:

```
RenderingServer.texture_set_shrink_all_x2_on_set_data(true)
```

Alternatively, you can also enable mipmaps on all your 2D textures. However,
enabling mipmaps will increase memory usage which may be problematic on low-end
mobile devices.

## Handling aspect ratios

Once scaling for different resolutions is accounted for, make sure that
your *user interface* also scales for different aspect ratios. This can be
done using `anchors` and/or `containers`.

## Field of view scaling

The 3D Camera node's **Keep Aspect** property defaults to the **Keep Height**
scaling mode (also called *Hor+*). This is usually the best value for desktop
games and mobile games in landscape mode, as widescreen displays will
automatically use a wider field of view.

However, if your 3D game is intended to be played in portrait mode, it may make
more sense to use **Keep Width** instead (also called *Vert-*). This way,
smartphones with an aspect ratio taller than 16:9 (e.g. 19:9) will use a
*taller* field of view, which is more logical here.

## Scaling 2D and 3D elements differently using Viewports

Using multiple Viewport nodes, you can have different scales for various
elements. For instance, you can use this to render the 3D world at a low
resolution while keeping 2D elements at the native resolution. This can improve
performance significantly while keeping the HUD and other 2D elements crisp.

This is done by using the root Viewport node only for 2D elements, then creating
a Viewport node to display the 3D world and displaying it using a
ViewportContainer or TextureRect node. There will effectively be two viewports
in the final project. One upside of using TextureRect over ViewportContainer is
that it allows enable linear filtering. This makes scaled 3D viewports look
better in many cases.

See the
[3D viewport scaling demo](../../07_demo_projects/viewport/3d_scaling/)
for examples.

