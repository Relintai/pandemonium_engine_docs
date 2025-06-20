
# Frequently asked questions

## What can I do with Pandemonium? How much does it cost? What are the license terms?

Pandemonium is [Free and Open-Source Software]( https://en.wikipedia.org/wiki/Free_and_open-source_software) available under the
[OSI-approved](https://opensource.org/licenses/MIT) MIT license. This means it is free as in "free speech" as well as in "free beer."

In short:

* You are free to download and use Pandemonium for any purpose: personal, non-profit, commercial, or otherwise.
* You are free to modify, distribute, redistribute, and remix Pandemonium to your heart's content, for any reason, both non-commercially and commercially.

All the contents of this accompanying documentation are published under
the permissive Creative Commons Attribution 3.0 ([CC-BY 3.0]( https://creativecommons.org/licenses/by/3.0/ )) license, with attribution
to "Péter Magyar and the Pandemonium community, and Juan Linietsky, Ariel Manzur and the Godot community".

Logos and icons are generally under the same Creative Commons license. Note
that some third-party libraries included with Pandemonium's source code may have
different licenses.

For full details, look at the [COPYRIGHT.txt](https://github.com/Relintai/pandemonium_engine/blob/master/COPYRIGHT.txt) as well
as the [LICENSE.txt](https://github.com/Relintai/pandemonium_engine/blob/master/LICENSE.txt) and [LOGO_LICENSE.txt](https://github.com/Relintai/pandemonium_engine/blob/master/LOGO_LICENSE.md) files in the Pandemonium repository.

Also, see [the license page on the Pandemonium website](https://pandemoniumengine.org/license).

## Which platforms are supported by Pandemonium?

**For the editor:**

* Windows
* macOS
* X11 (Linux, \*BSD)
* [Web](../03_usage/18_editor/04_using_the_web_editor.md)
* Android (experimental)

**For exporting your games:**

* Windows
* macOS
* X11 (Linux, \*BSD) (x64, x86, arm32, arm64)
* Android
* iOS
* Web
* Single Board Computers (FRT, and FRT SDL backends)
* Eventually UWP. (Currently needs working build containers, and some reworks.)

Both 32- and 64-bit binaries are supported where it makes sense, with 64
being the default.

Just like godot 3.x the codebase should compile for consoles. If you have access
to godot platform implementations for them, they should be simple to make work
with pandemonium aswell.

For more on this, see the sections on [exporting](../03_usage/20_export/)
and [compiling Pandemonium yourself](../05_engine_development/01_compiling).

## Which programming languages are supported in Pandemonium?

The officially supported languages for Pandemonium are GDScript, and C++.

If you are just starting out with either Pandemonium or game development in general,
GDScript is the recommended language to learn and use since it is native to Pandemonium.
While scripting languages tend to be less performant than lower-level languages in
the long run, for prototyping, developing Minimum Viable Products (MVPs), and
focusing on Time-To-Market (TTM), GDScript will provide a fast, friendly, and capable
way of developing your games.

### GDNative

GDNative is a C interface that lets you create and dynamically load dll-s.
Code in these dlls can use engine types, and can call engine methods, and
they can even create custom classes.

#### Python

Godot's [GDNative Python](https://github.com/Relintai/gdnative_python) ported to work with pandemonium.

It's setup in a self contained way. Can come in handy for tools,
as python has access to lots of great libraries, and you can
bundle them with your application using this module.

Only has binaries for desktop platforms.

I only recommend it for desktop tools where you want access to some of the python libraries,
but you also need a self contained application. It's a lot simpler than connecting and managing
multiple apps through sockets, but it's still relatively complex to set up.

#### C++

Godot's [GDNative C++](https://github.com/Relintai/gdnative_cpp) ported to work with pandemonium.

Currently under rework to make it's code (hopefully) identical to engine side c++. If successful,
engine side module code could be developed with faster recompile times, and even dynamic reloading
in some cases.

### C#

[C#](https://github.com/Relintai/mono) is available as an engine module,
which means you need to add it to the engine and recompile it to have it.

It comes with lots of complexities.

I only recommend it for tools, and when you need something from the c# ecosystem
integrated into your application.

Most of the time you are probably better off just writing GDScript, or engine modules in c++ though.

## What is GDScript and why should I use it?

GDScript is Pandemonium's integrated scripting language. It was built from the ground
up to maximize Pandemonium's potential in the least amount of code, affording both novice
and expert developers alike to capitalize on Pandemonium's strengths as fast as possible.
If you've ever written anything in a language like Python before then you'll feel
right at home. For examples, history, and a complete overview of the power GDScript
offers you, check out the [GDScript scripting guide](../03_usage/15_scripting/gdscript).

There are several reasons to use GDScript--especially when you are prototyping, in
alpha/beta stages of your project, or are not creating the next AAA title--but the
most salient reason is the overall **reduction of complexity**.

The original intent of creating a tightly integrated, custom scripting language for
Pandemonium was two-fold: first, it reduces the amount of time necessary to get up and running
with Pandemonium, giving developers a rapid way of exposing themselves to the engine with a
focus on productivity; second, it reduces the overall burden of maintenance, attenuates
the dimensionality of issues, and allows the developers of the engine to focus on squashing
bugs and improving features related to the engine core--rather than spending a lot of time
trying to get a small set of incremental features working across a large set of languages.

Since Pandemonium is an open-source project, it was imperative from the start to prioritize a
more integrated and seamless experience over attracting additional users by supporting
more familiar programming languages--especially when supporting those more familiar
languages would result in a worse experience. We understand if you would rather use
another language in Pandemonium (see the list of supported options above). That being said, if
you haven't given GDScript a try, try it for **three days**. Just like Pandemonium,
once you see how powerful it is and rapid your development becomes, we think GDScript
will grow on you.

## What were the motivations behind creating GDScript?

In the early days, the engine used the [Lua](https://www.lua.org)
scripting language. Lua is fast, but creating bindings to an object
oriented system (by using fallbacks) was complex and slow and took an
enormous amount of code. After some experiments with
[Python](https://www.python.org), it also proved difficult to embed.

The main reasons for creating a custom scripting language for Godot were:

1. Poor threading support in most script VMs, and Pandemonium uses threads
   (Lua, Python, Squirrel, JavaScript, ActionScript, etc.).
2. Poor class-extending support in most script VMs, and adapting to
   the way Pandemonium works is highly inefficient (Lua, Python, JavaScript).
3. Many existing languages have horrible interfaces for binding to C++, resulting in large amount of
   code, bugs, bottlenecks, and general inefficiency (Lua, Python,
   Squirrel, JavaScript, etc.) We wanted to focus on a great engine, not a great amount of integrations.
4. No native vector types (vector3, matrix4, etc.), resulting in highly
   reduced performance when using custom types (Lua, Python, Squirrel,
   JavaScript, ActionScript, etc.).
5. Garbage collector results in stalls or unnecessarily large memory
   usage (Lua, Python, JavaScript, ActionScript, etc.).
6. Difficulty to integrate with the code editor for providing code
   completion, live editing, etc. (all of them). This is well-supported
   by GDScript.

GDScript was designed to curtail the issues above, and more.

## What type of 3D model formats does Pandemonium support?

Currently Pandemonium supports glTF and OBJ.

FBX support was removed to reduce engine bloat, because glTF turned out to be easier to
use most of the time. Also FBX is proprietary format. The FBX2glTF tool can easily convert it.

However note that FBX support can be added back relatively easily from
[Godot](https://github.com/godotengine/godot/tree/3.x/modules/fbx) if needed.

## Will [insert closed SDK such as FMOD, GameWorks, etc.] be supported in Pandemonium?

The aim of Pandemonium is to create a free and open-source MIT-licensed engine that
is modular and extendable. There are no plans for the core engine development
community to support any third-party, closed-source/proprietary SDKs, as integrating
with these would go against Pandemonium's ethos.

That said, because Pandemonium is open-source and modular, nothing prevents you or
anyone else interested in adding those libraries as a module and shipping your
game with them--as either open- or closed-source.

To see how support for your SDK of choice could still be provided, look at the
Plugins question below.

If you know of a third-party SDK that is not supported by Pandemonium but that offers
free and open-source integration, consider starting the integration work yourself.
Pandemonium is not owned by one person; it belongs to the community, and it grows along
with ambitious community contributors like you.

## How do I install the Pandemonium editor on my system (for desktop integration)?

Since you don't need to actually install Pandemonium on your system to run it,
this means desktop integration is not performed automatically.

You can manually perform the steps that an installer would do for you:

### Windows

- Move the Pandemonium executable to a stable location (i.e. outside of your Downloads folder),
  so you don't accidentally move it and break the shortcut in the future.
- Right-click the Pandemonium executable and choose **Create Shortcut**.
- Move the created shortcut to `%LOCALAPPDATA%\Microsoft\Windows\Start Menu\Programs`.
  This is the user-wide location for shortcuts that will appear in the Start menu.
  You can also pin Pandemonium in the task bar by right-clicking the executable and choosing
  **Pin to Task Bar**.

### macOS

Drag the extracted Pandemonium application to `/Applications/Pandemonium.app`, then drag it
to the Dock if desired. Spotlight will be able to find Pandemonium as long as it's in
`/Applications` or `~/Applications`.

### Linux

- Move the Pandemonium binary to a stable location (i.e. outside of your Downloads folder),
  so you don't accidentally move it and break the shortcut in the future.
- Rename and move the Pandemonium binary to a location present in your `PATH` environment variable.
  This is typically `/usr/local/bin/pandemonium` or `/usr/bin/pandemonium`.
  Doing this requires administrator privileges,
  but this also allows you to
  [run the Pandemonium editor from a terminal](../03_usage/18_editor/01_command_line_tutorial.md) by entering `pandemonium`.

  - If you cannot move the Pandemonium editor binary to a protected location, you can
    keep the binary somewhere in your home directory, and modify the `Path=`
    line in the `.desktop` file linked below to contain the full *absolute* path
    to the Pandemonium binary.

- Save [this .desktop file](https://raw.githubusercontent.com/Relintai/pandemonium_engine/master/misc/dist/linux/org.pandemonium.Pandemonium.desktop)
  to `$HOME/.local/share/applications/`. If you have administrator privileges,
  you can also save the `.desktop` file to `/usr/local/share/applications`
  to make the shortcut available for all users.

## Is the Pandemonium editor a portable application?

In its default configuration, Pandemonium is *semi-portable*. Its executable can run
from any location (including non-writable locations) and never requires
administrator privileges.

However, configuration files will be written to the user-wide configuration or
data directory. This is usually a good approach, but this means configuration files
will not carry across machines if you copy the folder containing the Pandemonium executable.
See [this](../03_usage/07_io/02_data_paths.md) for more information.

If *true* portable operation is desired (e.g. for use on an USB stick),
follow the steps [here](../03_usage/07_io/02_data_paths.md#self-contained-mode).

## Why does Pandemonium use OpenGL instead of Direct3D?

Pandemonium aims for cross-platform compatibility and open standards first and
foremost. OpenGL is the technology that are both open and
available (nearly) on all platforms. Thanks to this design decision, a project
developed with Pandemonium on Windows will run out of the box on Linux, macOS, and
more.

On top of this, using a single API
on all platforms allows for greater consistency with fewer platform-specific
issues.

## Is Pandemonium aim to keep its core feature set small?

Pandemonium intentionally tries not include features that can be implemented by add-ons
unless they are used very often.

There are several reasons for this:

- **Code maintenance and surface for bugs.** Every time we accept new code in
  the Pandemonium repository, existing contributors often take the reponsibility of
  maintaining it. Some contributors don't always stick around after getting
  their code merged, which can make it difficult for us to maintain the code in
  question. This can lead to poorly maintained features with bugs that are never
  fixed. On top of that, the "API surface" that needs to be tested and checked
  for regressions keeps increasing over time.
- **Ease of contribution.** By keeping the codebase small and tidy, it can remain
  fast and easy to compile from source. This makes it easier for new
  contributors to get started with Pandemonium, without requiring them to purchase
  high-end hardware.
- **Keeping the binary size small for the editor.** Not everyone has a fast Internet
  connection. Ensuring that everyone can download the Pandemonium editor, extract it
  and run it in less than 5 minutes makes Pandemonium more accessible to developers in
  all countries.
- **Keeping the binary size small for export templates.** This directly impacts the
  size of projects exported with Pandemonium. On mobile and web platforms, keeping
  file sizes low is primordial to ensure fast installation and loading on
  underpowered devices. Again, there are many countries where high-speed
  Internet is not readily available. To add to this, strict data usage caps are
  often in effect in those countries.

For all the reasons above, we have to be selective of what we can accept as core
functionality in Pandemonium.

Of course "used very often" is relative to the point of view of any given observer.
It really depend on what kind of projects you are working on.

So please note that Pandemonium includes lots of features
that would be considered unconventional. (Web server, databases, smtp client, totp,
ai framework, etc.). It also includes things like a voxel engine, terrain engine,
an entity spell system. Most of these would be either impossible or just extremely
difficult to implement using the scripting languages.

However these are all modules, which means they can be disabled when compiling the engine.
You can (and probably should)
[compile your own custom export templates with unused features disabled](../05_engine_development/01_compiling/11_optimizing_for_size.md).

## How should assets be created to handle multiple resolutions and aspect ratios?

This question pops up often and it's probably thanks to the misunderstanding
created by Apple when they originally doubled the resolution of their devices.
It made people think that having the same assets in different resolutions was a
good idea, so many continued towards that path. That originally worked to a
point and only for Apple devices, but then several Android and Apple devices
with different resolutions and aspect ratios were created, with a very wide
range of sizes and DPIs.

The most common and proper way to achieve this is to, instead, use a single
base resolution for the game and only handle different screen aspect ratios.
This is mostly needed for 2D, as in 3D it's just a matter of Camera XFov or YFov.

1. Choose a single base resolution for your game. Even if there are
   devices that go up to 2K and devices that go down to 400p, regular
   hardware scaling in your device will take care of this at little or
   no performance cost. Most common choices are either near 1080p
   (1920x1080) or 720p (1280x720). Keep in mind the higher the
   resolution, the larger your assets, the more memory they will take
   and the longer the time it will take for loading.
2. Use the stretch options in Pandemonium; 2D stretching while keeping aspect
   ratios works best. Check the [multiple resolutions](../03_usage/14_rendering/02_multiple_resolutions.md) tutorial
   on how to achieve this.
3. Determine a minimum resolution and then decide if you want your game
   to stretch vertically or horizontally for different aspect ratios, or
   if there is one aspect ratio and you want black bars to appear
   instead. This is also explained in [multiple resolutions](../03_usage/14_rendering/02_multiple_resolutions.md).
4. For user interfaces, use the [anchoring](../03_usage/04_ui/01_size_and_anchors.md)
   to determine where controls should stay and move. If UIs are more
   complex, consider learning about Containers.

And that's it! Your game should work in multiple resolutions.

If there is a desire to make your game also work on ancient
devices with tiny screens (fewer than 300 pixels in width), you can use
the export option to shrink images, and set that build to be used for
certain screen sizes in the App Store or Google Play.

## How can I extend Pandemonium?

For extending Pandemonium, like creating Pandemonium Editor plugins or adding support
for additional languages, take a look at [EditorPlugins](../03_usage/19_plugins/editor/02_making_plugins.md)
and tool scripts.

You can also take a look at the GDScript implementation, and the Pandemonium modules.
This would be a good starting point to see how another third-party library
integrates with Pandemonium.

## When is the next release of Pandemonium out?

When it's ready! See [release policy](05_release_policy.md) for more
information.

## I would like to contribute! How can I get started?

Awesome! As an open-source project, Pandemonium thrives off of the innovation and
ambition of developers like you.

The first place to get started is in the [issues](https://github.com/Relintai/pandemonium_engine/issues).
Find an issue that resonates with you, then proceed to the [How to Contribute](https://github.com/Relintai/pandemonium_engine/blob/master/CONTRIBUTING.md#contributing-pull-requests)
guide to learn how to fork, modify, and submit a Pull Request (PR) with your changes.

## Is it possible to use Pandemonium to create non-game applications?

Yes! Pandemonium features an extensive built-in UI system, and its small distribution
size can make it a suitable alternative to frameworks like Electron or Qt.

When creating a non-game application, make sure to enable
`low-processor mode` in the Project Settings to decrease CPU and GPU usage.

Check out [pandemonium cms](https://github.com/Relintai/pandemonium_cms)
and [uml_generator](https://github.com/Relintai/uml_generator)
for examples of open source applications made with Pandemonium.

## Is it possible to use Pandemonium as a library?

Pandemonium is meant to be used with its editor. We recommend you give it a try, as it
will most likely save you time in the long term. There are no plans to make
Pandemonium usable as a library, as it would make the rest of the engine more
convoluted and difficult to use for casual users.

If you want to use a rendering library, look into using an established rendering
engine instead.

[SFW](https://github.com/Relintai/sfw) is also available.
it uses Pandemonium's core classes, it has a version with a simple renderer.
It is designed to be extremely simple to copmile and use
(the version with the rendrer is amalgamated into 3 files).

## What user interface toolkit does Pandemonium use?

Pandemonium does not use a standard GUI (Graphical User Interface) toolkit
like GTK, Qt or wxWidgets. Instead, Pandemonium uses its own user interface toolkit,
rendered using OpenGL ES. This toolkit is exposed in the form of
Control nodes, which are used to render the editor (which is written in C++).
These Control nodes can also be used in projects from any scripting language
supported by Pandemonium.

This custom toolkit makes it possible to benefit from hardware acceleration and
have a consistent appearance across all platforms. On top of that, it doesn't
have to deal with the LGPL licensing caveats that come with GTK or Qt. Lastly,
this means Pandemonium is "eating its own dog food" since the editor itself is one of
the most complex users of Pandemonium's UI system.

This custom UI toolkit can't be used as a library,
but you can still use Pandemonium to create non-game applications by using the editor.

## Why does Pandemonium not use STL (Standard Template Library)?

Like many other libraries (Qt as an example), Pandemonium does not make use of STL.
STL might be okay for small programs, I personally don't believe it should be used
for any program bigger than a few hundred lines due to it's design. (This is actually
one of the reasons why [SFW](https://github.com/Relintai/sfw) was created.)

* STL templates create very large symbols, which results in huge debug binaries. We use few templates with very short names instead.
* Most of our containers cater to special needs, like Vector, which uses copy on write and we use to pass data around,
  or the RID system, which requires O(1) access time for performance. Likewise, our hash map implementations are designed
  to integrate seamlessly with internal engine types.
* Our containers have memory tracking built-in, which helps better track memory usage. They also doens't allow over and under indexing.
* For large arrays, we use pooled memory, which can be mapped to either a preallocated buffer or virtual memory.
* We use our custom String type, as the one provided by STL is too basic and lacks proper internationalization support.
* STL templates have extremely limited functionality, while at the same time being extremely bloated code-wise. They are also slow.
* STL template apis are hard to use properly, are hard on the eyes, and they are easy to misuse to cause memory corruption issues.
* Their compile errors are hard to read.

And unfortunately this list could go on.

So please keep in mind, STL containers are what they are. They should be used for what they are good at.
And that is why lots of serious codebases opt not to use them.

The issue is that people in most mainstream places thinking that since they are available
they should be used no matter what. This isn't proper engineering. Thinking like this is going to cost you in the long term.

Even in java people sometimes implement their own data structures. (Just take a look at LibGDX.)

On the bright side, in c++ we are not stuck using default implementations from anything. (Think java and c# immutable Strings.)

## Why does Pandemonium not use exceptions?

We believe games should not crash, no matter what. If an unexpected
situation happens, Pandemonium will print an error (which can be traced even to
script), but then it will try to recover as gracefully as possible and keep
going.

Additionally, exceptions significantly increase binary size for the
executable, they are also very slow.

## Why does Pandemonium not use RTTI by default?

Pandemonium provides its own type-casting system, which can optionally use RTTI
internally. Disabling RTTI in Pandemonium means considerably smaller binary sizes can
be achieved.

Also apprently the built-in casting is 7x faster than `dynamic_cast`.
[See this godot pull request](https://github.com/godotengine/godot/pull/103708).

## Why does Pandemonium not force users to implement DoD (Data oriented Design)?

While Pandemonium internally for a lot of the heavy performance tasks attempts
to use cache coherency as well as possible, we believe most users don't
really need to be forced to use DoD practices.

DoD is mostly a cache coherency optimization that can only gain you
significant performance improvements when dealing with dozens of
thousands of objects (which are processed every frame with little
modification). As in, if you are moving a few hundred sprites or enemies
per frame, DoD won't help you, and you should consider a different approach
to optimization.

The vast majority of games do not need this and Pandemonium provides handy helpers
to do the job for most cases when you do.

If a game that really needs to process such large amount of objects is
needed, our recommendation is to use C++ and GDNative for the high
performance parts and GDScript (or C#) for the rest of the game.

