
# Differences between GLES2 and GLES3

This page documents the differences between GLES2 and GLES3 that are by design and are not the result
of bugs. There may be differences that are unintentional, but they should be reported as bugs.

Note: "GLES2" and "GLES3" are the names used in Pandemonium for the two OpenGL-based rendering backends.
In terms of graphics APIs, the GLES2 backend maps to OpenGL 2.1 on desktop, OpenGL ES 2.0 on
mobile and WebGL 1.0 on the web. The GLES3 backend maps to OpenGL 3.3 on desktop, OpenGL ES
3.0 on mobile and WebGL 2.0 on the web.

## Particles

GLES2 cannot use the `Particles` or `Particles2D` nodes
as they require advanced GPU features. Instead, use `CPUParticles` or
`CPUParticles2D`, which provides a similar interface to a
`ParticlesMaterial`.

Tip: Particles and Particles2D can be converted to their CPU equivalent node with the "Convert to
CPUParticles" option in the editor.

## `SCREEN_TEXTURE` mip-maps

In GLES2, `SCREEN_TEXTURE` (accessed via a `ShaderMaterial`) does not have
computed mip-maps. So when accessing at a different LOD, the texture will not appear blurry.

## `DEPTH_TEXTURE`

While GLES2 supports `DEPTH_TEXTURE` in shaders, it may not work on some old hardware (especially mobile).

## Color space

GLES2 and GLES3 are in different color spaces. This means that colors will appear slightly
different between them especially when lighting is used.

If your game is going to use both GLES2 and GLES3, you can use an `if`
statement check and see if the output is in sRGB, using `OUTPUT_IS_SRGB`. `OUTPUT_IS_SRGB` is
`true` in GLES2 and `false` in GLES3.

## HDR

GLES2 is not capable of using High Dynamic Range (HDR) rendering features. If HDR is set for your
project, or for a given viewport, Pandemonium will still use Low Dynamic Range (LDR) which limits
viewport values to the `0-1` range.

The Viewport **Debanding** property and associated project setting will also have
no effect when HDR is disabled. This means debanding can't be used in GLES2.

## SpatialMaterial features

In GLES2, the following advanced rendering features in the `SpatialMaterial` are missing:

- Refraction
- Subsurface scattering
- Anisotropy
- Clearcoat
- Depth mapping

When using SpatialMaterials they will not even appear in the editor.

In custom `ShaderMaterials`, you can set values for these features but they
will be non-functional. For example, you will still be able to set the `SSS` built-in (which normally adds
subsurface scattering) in your shader, but nothing will happen.

## Environment features

In GLES2, the following features in the `Environment3D` are missing:

- Auto exposure
- Tonemapping
- Screen space reflections
- Screen space ambient occlusion

That means that in GLES2 environments you can only set:

- Sky (including procedural sky)
- Ambient light
- Fog
- Depth of field
- Glow (also known as bloom)
- Adjustment

## GIProbes

`GIProbes` do not work in GLES2. Instead use `Baked Lightmaps`.
For a description of how baked lightmaps work see the `Baked Lightmaps tutorial`.

## Contact shadows

The `shadow_contact` property of `Lights` is not supported in GLES2 and so does nothing.

## Light performance

In GLES2, performance scales poorly with several lights, as each light is processed in a separate render
pass (in opposition to GLES3 which is all done in a single pass). Try to limit scenes to as few lights as
possible in order to achieve greatest performance.

## Texture compression

On mobile, GLES2 requires ETC texture compression, while GLES3 requires ETC2. ETC2 is enabled by default,
so if exporting to mobile using GLES2 make sure to set the project setting
`rendering/vram_compression/import_etc` and then reimport textures.

Warning: Since ETC doesn't support transparency, you must reimport textures that contain
an alpha channel to use the Uncompressed, Lossy or Lossless compression mode
(instead of Video RAM). This can be done in the Import dock after selecting
them in the FileSystem dock.

## Blend shapes

In GLES2, blend shapes are implemented on the CPU instead of the GPU.
Accordingly, they may not perform as well as blend shapes in GLES3. To avoid
performance issues when using blend shapes in GLES2, try to minimize the number
of blend shapes that are updated each frame.

## Shading language

GLES3 provides many built-in functions that GLES2 does not. Below is a list of functions
that are not available or are have limited support in GLES2.

| Function                                                                                    |                                                  |
|---------------------------------------------------------------------------------------------|--------------------------------------------------|
| vec_type **modf** ( vec_type x, out vec_type i )                                            |                                                  |
| vec_int_type **floatBitsToInt** ( vec_type x )                                              |                                                  |
| vec_uint_type **floatBitsToUint** ( vec_type x )                                            |                                                  |
| vec_type **intBitsToFloat** ( vec_int_type x )                                              |                                                  |
| vec_type **uintBitsToFloat** ( vec_uint_type x )                                            |                                                  |
| ivec2 **textureSize** ( sampler2D_type s, int lod )                                         | See workaround below                             |
| ivec2 **textureSize** ( samplerCube s, int lod )                                            | See workaround below                             |
| vec4_type **texture** ( sampler_type s, vec_type uv [, float bias] )                        | **bias** not available in vertex shader          |
| vec4_type **textureProj** ( sampler_type s, vec_type uv [, float bias] )                    |                                                  |
| vec4_type **textureLod** ( sampler_type s, vec_type uv, float lod )                         | Only available in vertex shader on some hardware |
| vec4_type **textureProjLod** ( sampler_type s, vec_type uv, float lod )                     |                                                  |
| vec4_type **textureGrad** ( sampler_type s, vec_type uv, vec_type dPdx, vec_type dPdy )     |                                                  |
| vec_type **dFdx** ( vec_type p )                                                            |                                                  |
| vec_type **dFdy** ( vec_type p )                                                            |                                                  |
| vec_type **fwidth** ( vec_type p )                                                          |                                                  |

Note: Functions not in GLES2's GLSL were added with Pandemoniums own shader standard library. These functions may perform worse in GLES2 compared to GLES3.

### `textureSize()` workaround

GLES2 does not support `textureSize()`. You can get the size of a texture the old fashioned way by passing in a
uniform with the texture size yourself.

```
// In the shader:
uniform sampler2D textureName;
uniform vec2 textureName_size;
```

```
# In GDScript:
material_name.set_shader_param("textureName", my_texture)
material_name.set_shader_param("textureName_size", my_texture_size)
```

## Built in variables and render modes

Pandemonium also provides many built-in variables and render modes. Some cannot be supported in GLES2. Below is a list of
built-in variables and render modes that, when written to, will have no effect or could even cause issues when using
the GLES2 backend.

| Variable / Render Mode     |
`----------------------------`
| `ensure_correct_normals` |
| `INSTANCE_ID`            |
| `DEPTH`                  |
| `ANISOTROPY`             |
| `ANISOTROPY_FLOW`        |
| `SSS_STRENGTH`           |

