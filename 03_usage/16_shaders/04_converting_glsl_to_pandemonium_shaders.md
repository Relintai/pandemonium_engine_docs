
# Converting GLSL to Pandemonium shaders

This document explains the differences between Pandemonium's shading language and GLSL
and gives practical advice on how to migrate shaders from other sources, such as
Shadertoy and The Book of Shaders, into Pandemonium shaders.

## GLSL

Pandemonium uses a shading language based on GLSL with the addition of a few
quality-of-life features. Accordingly, most features available in GLSL are
available in Pandemonium's shading language.

#### Shader programs

In GLSL, each shader uses a separate program. You have one program for the
vertex shader and one for the fragment shader. In Pandemonium, you have a single
shader that contains a `vertex` and/or a `fragment` function. If you only
choose to write one, Pandemonium will supply the other.

Pandemonium allows uniform variables and functions to be shared by defining the
fragment and vertex shaders in one file. In GLSL, the vertex and fragment
programs cannot share variables except when varyings are used.

#### Vertex attributes

In GLSL, you can pass in per-vertex information using attributes and have the
flexibility to pass in as much or as little as you want. In Pandemonium, you have a
set number of input attributes, including `VERTEX` (position), `COLOR`,
`UV`, `UV2`, `NORMAL`.

#### gl_Position

`gl_Position` receives the final position of a vertex specified in the vertex
shader. It is specified by the user in clip space. Typically, in GLSL, the model
space vertex position is passed in using a vertex attribute called `position`
and you handle the conversion from model space to clip space manually.

In Pandemonium, `VERTEX` specifies the vertex position in model space at the
beginning of the `vertex` function. Pandemonium also handles the final conversion to
clip space after the user-defined `vertex` function is run. If you want to
skip the conversion from model to view space, you can set the `render_mode` to
`skip_vertex_transform`. If you want to skip all transforms, set
`render_mode` to `skip_vertex_transform` and set the `PROJECTION_MATRIX`
to `mat4(1.0)` in order to nullify the final transform from view space to clip
space.

#### Varyings

Varyings are a type of variable that can be passed from the vertex shader to the
fragment shader. In modern GLSL (3.0 and up), varyings are defined with the
`in` and `out` keywords. A variable going out of the vertex shader is
defined with `out` in the vertex shader and `in` inside the fragment shader.

#### Main

In GLSL, each shader program looks like a self-contained C-style program.
Accordingly, the main entry point is `main`. If you are copying a vertex
shader, rename `main` to `vertex` and if you are copying a fragment shader,
rename `main` to `fragment`.

#### Constants

Global array constants are not supported in Pandemonium 3.x. You can fake the functionality by using a uniform
initialized to the value, but you will not benefit from the increased speed from using a constant.

#### Macros

In keeping with its similarity to C, GLSL lets you use macros. Commonly
`#define` is used to define constants or small functions. There is no
straightforward way to translate defines to Pandemonium's shading language. If it is a
function that is defined, then replace with a function, and if it is a constant,
then replace with a uniform. For other macros (`#if`, `#ifdef`, etc.), there
is no equivalent because they run during the pre-processing stage of
compilation.

#### Variables

GLSL has many built-in variables that are hard-coded. These variables are not
uniforms, so they are not editable from the main program.


| Variable             | Type     | Equivalent              | Description                                          |
|----------------------|----------|-------------------------|------------------------------------------------------|
| gl_FragColor         | out vec4 | COLOR                   | Output color for each pixel.                         |
| gl_FragCoord         | vec4     | FRAGCOORD               | For full screen quads. For smaller quads, use UV.    |
| gl_Position          | vec4     | VERTEX                  | Position of Vertex, output from Vertex Shader.       |
| gl_PointSize         | float    | POINT_SIZE              | Size of Point primitive.                             |
| gl_PointCoord        | vec2     | POINT_COORD             | Position on point when drawing Point primitives.     |
| gl_FrontFacing       | bool     | FRONT_FACING            | True if front face of primitive.                     |


#### Coordinates

`gl_FragCoord` in GLSL and `FRAGCOORD` in the Pandemonium shading language use the
same coordinate system. If using UV in Pandemonium, the y-coordinate will be flipped
upside down.

#### Precision

In GLSL, you can define the precision of a given type (float or int) at the top
of the shader with the `precision` keyword. In Pandemonium, you can set the
precision of individual variables as you need by placing precision qualifiers
`lowp`, `mediump`, and `highp` before the type when defining the variable.

#### Shadertoy

[Shadertoy](https://www.shadertoy.com/results?query=&sort=popular&from=10&num=4)
is a website that makes it easy to write fragment shaders and
create [pure magic](https://www.shadertoy.com/view/4tjGRh).

Shadertoy does not give the user full control over the shader. It handles all
the input and uniforms and only lets the user write the fragment shader.

#### Types

Shadertoy uses the webgl spec, so it runs a slightly different version of GLSL.
However, it still has the regular types, including constants and macros.

#### mainImage

The main point of entry to a Shadertoy shader is the `mainImage` function.
`mainImage` has two parameters, `fragColor` and `fragCoord`, which
correspond to `COLOR` and `FRAGCOORD` in Pandemonium, respectively. These
parameters are handled automatically in Pandemonium, so you do not need to include
them as parameters yourself. Anything in the `mainImage` function should be
copied into the `fragment` function when porting to Pandemonium.

#### Variables

In order to make writing fragment shaders straightforward and easy, Shadertoy
handles passing a lot of helpful information from the main program into the
fragment shader for you. A few of these have no equivalents in Pandemonium because
Pandemonium has chosen not to make them available by default. This is okay because
Pandemonium gives you the ability to make your own uniforms. For variables whose
equivalents are listed as "Provide with Uniform", users are responsible for
creating that uniform themselves. The description gives the reader a hint about
what they can pass in as a substitute.


| Variable             | Type      | Equivalent               | Description                                          |
|----------------------|-----------|--------------------------|------------------------------------------------------|
| fragColor            | out vec4  | COLOR                    | Output color for each pixel.                         |
| fragCoord            | vec2      | FRAGCOORD.xy             | For full screen quads. For smaller quads, use UV.    |
| iResolution          | vec3      | 1.0 / SCREEN_PIXEL_SIZE  | Can also pass in manually.                           |
| iTime                | float     | TIME                     | Time since shader started.                           |
| iTimeDelta           | float     | Provide with Uniform     | Time to render previous frame.                       |
| iFrame               | float     | Provide with Uniform     | Frame number.                                        |
| iChannelTime[4]      | float     | Provide with Uniform     | Time since that particular texture started.          |
| iMouse               | vec4      | Provide with Uniform     | Mouse position in pixel coordinates.                 |
| iDate                | vec4      | Provide with Uniform     | Current date, expressed in seconds.                  |
| iChannelResolution[4]| vec3      | 1.0 / TEXTURE_PIXEL_SIZE | Resolution of particular texture.                    |
| iChanneli            | Sampler2D | TEXTURE                  | Pandemonium provides only one built-in; user can make more.|

#### Coordinates

`fragCoord` behaves the same as `gl_FragCoord` in `GLSL` and `FRAGCOORD` in Pandemonium.


## The Book of Shaders

Similar to Shadertoy, [The Book of Shaders](https://thebookofshaders.com)
provides access to a fragment shader in the web browser, with which the user may
interact. The user is restricted to writing fragment shader code with a set list
of uniforms passed in and with no ability to add additional uniforms.

For further help on porting shaders to various frameworks generally, The Book of
Shaders provides a [page](https://thebookofshaders.com/04) on running shaders
in various frameworks.

#### Types

The Book of Shaders uses the webgl spec, so it runs a slightly different version
of GLSL. However, it still has the regular types, including constants and
macros.

#### Main

The entry point for a Book of Shaders fragment shader is `main`, just like in
GLSL. Everything written in a Book of Shaders `main` function should be copied
into Pandemonium's `fragment` function.

#### Variables

The Book of Shaders sticks closer to plain GLSL than Shadertoy does. It also
implements fewer uniforms than Shadertoy.


| Variable             | Type     | Equivalent              | Description                                          |
|----------------------|----------|-------------------------|------------------------------------------------------|
| gl_FragColor         | out vec4 | COLOR                   | Output color for each pixel.                         |
| gl_FragCoord         | vec4     | FRAGCOORD               | For full screen quads. For smaller quads, use UV.    |
| u_resolution         | vec2     | 1.0 / SCREEN_PIXEL_SIZE | Can also pass in manually.                           |
| u_time               | float    | TIME                    | Time since shader started.                           |
| u_mouse              | vec2     | Provide with Uniform    | Mouse position in pixel coordinates.                 |


#### Coordinates

The Book of Shaders uses the same coordinate system as `GLSL`.

