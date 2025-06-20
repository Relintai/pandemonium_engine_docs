
# Complying with licenses

## What are licenses?

Pandemonium is created and distributed under the [MIT License](https://opensource.org/licenses/MIT).
It doesn't have a sole owner either, as every contributor that submits code to
the project does it under this same license and keeps ownership of the
contribution.

The license is the legal requirement for you (or your company) to use and
distribute the software (and derivative projects, including games made with it).
Your game or project can have a different license, but it still needs to comply
with the original one.

Warning:

    In your project's credits screen, remember to also list third-party notices
    for assets you're using, such as textures, models, sounds, music and fonts.

    Free assets in particular often come with licenses that require attribution.
    Double-check their license before using those assets in a project.

## Requirements

In the case of the MIT license, the only requirement is to include the license
text somewhere in your game or derivative project.

This text reads as follows:

    This game uses Pandemonium Engine, available under the following license:

    Copyright (c) 2022-present Péter Magyar.
    Copyright (c) 2014-2022 Godot Engine contributors (cf. AUTHORS.md).
    Copyright (c) 2007-2022 Juan Linietsky, Ariel Manzur.

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.


Note:

    Your games do not need to be under the same license. You are free to release
    your Pandemonium projects under any license and to create commercial games with
    the engine.

## Inclusion

The license does not specify how it has to be included, so anything is valid as
long as it can be displayed under some condition. These are the most common
approaches (only need to implement one of them, not all).

### Credits screen

Include the above license text somewhere in the credits screen. It can be at the
bottom after showing the rest of the credits. Most large studios use this
approach with open source licenses.

### Licenses screen

Some games have a special menu (often in the settings) to display licenses.

### Output log

Just printing the licensing text using the `print()`
function may be enough on platforms where a global output log is readable.
This is the case on desktop platforms, Android and HTML5 (but not iOS and UWP).

### Accompanying file

If the game is distributed on desktop platforms, a file containing the license
can be added to the software that is installed to the user PC.

### Printed manual

If the game includes printed manuals, license text can be included there.

### Link to the license

The Pandemonium Engine developers consider that a link to
`https://github.com/Relintai/pandemonium_engine/blob/master/LICENSE.txt`
in your game documentation or credits would be an acceptable way to satisfy
the license terms.

### License UI implementation

[Here](https://github.com/Relintai/broken_seals/tree/master/game/ui/windows/about) is a
window implementation that will show all licenses (even third-party ones) and engine information.

Eventually this will likely be implemented as a module on the engine side, so including it
will become only a few clicks.

## Third-party licenses

Pandemonium itself contains software written by third parties.
Most of it does not require license inclusion, but some do.
Make sure to do it if these are compiled in your Pandemonium export template. If
you're using the official export templates, all libraries are enabled. This
means you need to provide attribution for all the libraries listed below.

The `Engine` singleton can be used to retrieve the active third party license information.
See the `Engine.get_license_info()` method.

### FreeType

Pandemonium uses [FreeType](https://www.freetype.org/) to render fonts. Its license
requires attribution, so the following text must be included together with the
Pandemonium license:

    Portions of this software are copyright © ( year> The FreeType Project (www.freetype.org).  All rights reserved.

Note:

    ( year> should correspond to the value from the FreeType version used
    in your build. This information can be found in the editor by opening
    the **Help > About** dialog and going to the **Third-party Licenses**
    tab.

### ENet

Pandemonium includes the [ENet](http://enet.bespin.org/) library to handle
high-level multiplayer. ENet has similar licensing terms as Pandemonium:

    Copyright (c) 2002-2020 Lee Salzman

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

### mbed TLS

Pandemonium includes [mbed TLS](https://tls.mbed.org).

The Apache license needs to be complied to by including the following text:

    Copyright The Mbed TLS Contributors

    Licensed under the Apache License, Version 2.0 (the "License"); you may
    not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

