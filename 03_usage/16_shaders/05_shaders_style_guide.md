
# Shaders style guide

This style guide lists conventions to write elegant shaders. The goal is to
encourage writing clean, readable code and promote consistency across projects,
discussions, and tutorials. Hopefully, this will also support the development of
auto-formatting tools.

Since the Pandemonium shader language is close to C-style languages and GLSL, this
guide is inspired by Pandemonium's own GLSL formatting. You can view an example of a
GLSL file in Pandemonium's source code
[here](https://github.com/Relintai/pandemonium_engine/blob/master/drivers/gles2/shaders/copy.glsl).

Style guides aren't meant as hard rulebooks. At times, you may not be able to
apply some of the guidelines below. When that happens, use your best judgment,
and ask fellow developers for insights.

In general, keeping your code consistent in your projects and within your team is
more important than following this guide to a tee.

Note: Pandemonium's built-in shader editor uses a lot of these conventions
by default. Let it help you.

Here is a complete shader example based on these guidelines:

```
shader_type canvas_item;
// Screen-space shader to adjust a 2D scene's brightness, contrast
// and saturation. Taken from
// https://github.com/Relintai/pandemonium_engine-demo-projects/blob/master/2d/screen_space_shaders/shaders/BCS.shader

uniform float brightness = 0.8;
uniform float contrast = 1.5;
uniform float saturation = 1.8;

void fragment() {
    vec3 c = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).rgb;

    c.rgb = mix(vec3(0.0), c.rgb, brightness);
    c.rgb = mix(vec3(0.5), c.rgb, contrast);
    c.rgb = mix(vec3(dot(vec3(1.0), c.rgb) * 0.33333), c.rgb, saturation);

    COLOR.rgb = c;
}
```

## Formatting

### Encoding and special characters

* Use line feed (**LF**) characters to break lines, not CRLF or CR. *(editor default)*
* Use one line feed character at the end of each file. *(editor default)*
* Use **UTF-8** encoding without a [byte order mark](https://en.wikipedia.org/wiki/Byte_order_mark). *(editor default)*
* Use **Tabs** instead of spaces for indentation. *(editor default)*

### Indentation

Each indent level should be one tab greater than the block containing it.

**Good**:

```
void fragment() {
    COLOR = vec3(1.0, 1.0, 1.0);
}
```

**Bad**:

```
void fragment() {
        COLOR = vec3(1.0, 1.0, 1.0);
}
```

Use 2 indent levels to distinguish continuation lines from
regular code blocks.

**Good**:

```
vec2 st = vec2(
        atan(NORMAL.x, NORMAL.z),
        acos(NORMAL.y));
```

**Bad**:

```
vec2 st = vec2(
    atan(NORMAL.x, NORMAL.z),
    acos(NORMAL.y));
```


### Line breaks and blank lines

For a general indentation rule, follow
[the "1TBS Style"](https://en.wikipedia.org/wiki/Indentation_style#Variant:_1TBS_(OTBS))
which recommends placing the brace associated with a control statement on the
same line. Always use braces for statements, even if they only span one line.
This makes them easier to refactor and avoids mistakes when adding more lines to
an `if` statement or similar.

**Good**:

```
void fragment() {
    if (true) {
        // ...
    }
}
```

**Bad**:

```
void fragment()
{
    if (true)
        // ...
}
```

### Blank lines

Surround function definitions with one (and only one) blank line:

```
void do_something() {
    // ...
}

void fragment() {
    // ...
}
```

Use one (and only one) blank line inside functions to separate logical sections.

### Line length

Keep individual lines of code under 100 characters.

If you can, try to keep lines under 80 characters. This helps to read the code
on small displays and with two shaders opened side-by-side in an external text
editor. For example, when looking at a differential revision.

### One statement per line

Never combine multiple statements on a single line.

**Good**:

```
void fragment() {
    ALBEDO = vec3(1.0);
    EMISSION = vec3(1.0);
}
```

**Bad**:

```
void fragment() {
    ALBEDO = vec3(1.0); EMISSION = vec3(1.0);
}
```

The only exception to that rule is the ternary operator:

```
void fragment() {
     bool should_be_white = true;
     ALBEDO = should_be_white ? vec3(1.0) : vec3(0.0);
 }
```

### Comment spacing

Regular comments should start with a space, but not code that you comment out.
This helps differentiate text comments from disabled code.

**Good**:

```
// This is a comment.
//return;
```

**Bad**:

```
//This is a comment.
// return;
```

Don't use multiline comment syntax if your comment can fit on a single line:

```
/* This is another comment. */
```

Note: In the shader editor, to make the selected code a comment (or uncomment it),
press `Ctrl + K`. This feature adds or removes `//` at the start of
the selected lines.

### Whitespace

Always use one space around operators and after commas. Also, avoid extraneous spaces
in function calls.

**Good**:

```
COLOR.r = 5.0;
COLOR.r = COLOR.g + 0.1;
COLOR.b = some_function(1.0, 2.0);
```

**Bad**:

```
COLOR.r=5.0;
COLOR.r = COLOR.g+0.1;
COLOR.b = some_function (1.0,2.0);
```

Don't use spaces to align expressions vertically:

```
ALBEDO.r   = 1.0;
EMISSION.r = 1.0;
```

### Floating-point numbers

Always specify at least one digit for both the integer and fractional part. This
makes it easier to distinguish floating-point numbers from integers, as well as
distinguishing numbers greater than 1 from those lower than 1.

**Good**:

```
void fragment() {
    ALBEDO.rgb = vec3(5.0, 0.1, 0.2);
}
```

**Bad**:

```
void fragment() {
    ALBEDO.rgb = vec3(5., .1, .2);
}
```

## Accessing vector members

Use `r`, `g`, `b`, and `a` when accessing a vector's members if it
contains a color. If the vector contains anything else than a color, use `x`,
`y`, `z`, and `w`. This allows those reading your code to better
understand what the underlying data represents.

**Good**:

```
COLOR.rgb = vec3(5.0, 0.1, 0.2);
```

**Bad**:

```
COLOR.xyz = vec3(5.0, 0.1, 0.2);
```

## Naming conventions

These naming conventions follow the Pandemonium Engine style. Breaking these will make
your code clash with the built-in naming conventions, leading to inconsistent
code.

### Functions and variables

Use snake_case to name functions and variables:

```
void some_function() {
     float some_variable = 0.5;
}
```

### Constants

Write constants with CONSTANT_CASE, that is to say in all caps with an
underscore (_) to separate words:

```
const float GOLDEN_RATIO = 1.618;
```

## Code order

We suggest to organize shader code this way:

```
01. shader type declaration
02. render mode declaration
03. // docstring

04. uniforms
05. constants
06. varyings

07. other functions
08. vertex() function
09. fragment() function
10. light() function
```

We optimized the order to make it easy to read the code from top to bottom, to
help developers reading the code for the first time understand how it works, and
to avoid errors linked to the order of variable declarations.

This code order follows two rules of thumb:

1. Metadata and properties first, followed by methods.
2. "Public" comes before "private". In a shader language's context, "public"
   refers to what's easily adjustable by the user (uniforms).

### Local variables

Declare local variables as close as possible to their first use. This makes it
easier to follow the code, without having to scroll too much to find where the
variable was declared.

