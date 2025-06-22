
# Binding to external libraries

## Modules

The Summator example in custom modules in c++ is great for small,
custom modules, but what if you want to use a larger, external library?
Let's look at an example using [Festival](http://www.cstr.ed.ac.uk/projects/festival/),
a speech synthesis (text-to-speech) library written in C++.

To bind to an external library, set up a module directory similar to the Summator example:

```
pandemonium/modules/tts/
```

Next, you will create a header file with a simple TTS class:

```
/* tts.h */

#ifndef PANDEMONIUM_TTS_H
#define PANDEMONIUM_TTS_H

#include "core/reference.h"

class TTS : public Reference {
    GDCLASS(TTS, Reference);

protected:
    static void _bind_methods();

public:
    bool say_text(String p_txt);

    TTS();
};

#endif // PANDEMONIUM_TTS_H
```

And then you'll add the cpp file.

```
/* tts.cpp */

#include "tts.h"

#include <festival.h>

bool TTS::say_text(String p_txt) {

    //convert Pandemonium String to Pandemonium CharString to C string
    return festival_say_text(p_txt.ascii().get_data());
}

void TTS::_bind_methods() {

    ClassDB::bind_method(D_METHOD("say_text", "txt"), &TTS::say_text);
}

TTS::TTS() {
    festival_initialize(true, 210000); //not the best way to do it as this should only ever be called once.
}
```

Just as before, the new class needs to be registered somehow, so two more files
need to be created:

```
register_types.h
register_types.cpp
```

Important:

    These files must be in the top-level folder of your module (next to your
    `SCsub` and `config.py` files) for the module to be registered properly.

These files should contain the following:

```
/* register_types.h */

void register_tts_types();
void unregister_tts_types();
/* yes, the word in the middle must be the same as the module folder name */
```

```
/* register_types.cpp */

#include "register_types.h"

#include "core/class_db.h"
#include "tts.h"

void register_tts_types() {
    ClassDB::register_class<TTS>();
}

void unregister_tts_types() {
    // Nothing to do here in this example.
}
```

Next, you need to create a `SCsub` file so the build system compiles
this module:

```
# SCsub

Import('env')

env_tts = env.Clone()
env_tts.add_source_files(env.modules_sources, "*.cpp") # Add all cpp files to the build
```

You'll need to install the external library on your machine to get the .a library files. See the library's official
documentation for specific instructions on how to do this for your operation system. We've included the
installation commands for Linux below, for reference.

```
sudo apt-get install festival festival-dev <-- Installs festival and speech_tools libraries
apt-cache search festvox-* <-- Displays list of voice packages
sudo apt-get install festvox-don festvox-rablpc16k festvox-kallpc16k festvox-kdlpc16k <-- Installs voices
```

Important:

    The voices that Festival uses (and any other potential external/3rd-party
    resource) all have varying licenses and terms of use; some (if not most) of them may be
    be problematic with Pandemonium, even if the Festival Library itself is MIT License compatible.
    Please be sure to check the licenses and terms of use.

The external library will also need to be installed inside your module to make the source
files accessible to the compiler, while also keeping the module code self-contained. The
festival and speech_tools libraries can be installed from the modules/tts/ directory via
git using the following commands:

```
git clone https://github.com/festvox/festival
git clone https://github.com/festvox/speech_tools
```

If you don't want the external repository source files committed to your repository, you
can link to them instead by adding them as submodules (from within the modules/tts/ directory), as seen below:

```
git submodule add https://github.com/festvox/festival
git submodule add https://github.com/festvox/speech_tools
```

Important:

    Please note that Git submodules are not used in the Pandemonium repository. If
    you are developing a module to be merged into the main Pandemonium repository, you should not
    use submodules. If your module doesn't get merged in, you can always try to implement
    the external library as a GDNative C++ plugin.

To add include directories for the compiler to look at you can append it to the
environment's paths:

```
# These paths are relative to /modules/tts/
env_tts.Append(CPPPATH=["speech_tools/include", "festival/src/include"])

# LIBPATH and LIBS need to be set on the real "env" (not the clone)
# to link the specified libraries to the Pandemonium executable.

# This is a path relative to /modules/tts/ where your .a libraries reside.
# If you are compiling the module externally (not in the pandemonium source tree),
# these will need to be full paths.
env.Append(LIBPATH=['libpath'])

# Check with the documentation of the external library to see which library
# files should be included/linked.
env.Append(LIBS=['Festival', 'estools', 'estbase', 'eststring'])
```

If you want to add custom compiler flags when building your module, you need to clone
`env` first, so it won't add those flags to whole Pandemonium build (which can cause errors).
Example `SCsub` with custom flags:

```
# SCsub

Import('env')

env_tts = env.Clone()
env_tts.add_source_files(env.modules_sources, "*.cpp")
# Append CCFLAGS flags for both C and C++ code.
env_tts.Append(CCFLAGS=['-O2'])
# If you need to, you can:
# - Append CFLAGS for C code only.
# - Append CXXFLAGS for C++ code only.
```

The final module should look like this:

```
pandemonium/modules/tts/festival/
pandemonium/modules/tts/libpath/libestbase.a
pandemonium/modules/tts/libpath/libestools.a
pandemonium/modules/tts/libpath/libeststring.a
pandemonium/modules/tts/libpath/libFestival.a
pandemonium/modules/tts/speech_tools/
pandemonium/modules/tts/config.py
pandemonium/modules/tts/tts.h
pandemonium/modules/tts/tts.cpp
pandemonium/modules/tts/register_types.h
pandemonium/modules/tts/register_types.cpp
pandemonium/modules/tts/SCsub
```

## Using the module

You can now use your newly created module from any script:

```
var t = TTS.new()
var script = "Hello world. This is a test!"
var is_spoken = t.say_text(script)
print('is_spoken: ', is_spoken)
```

And the output will be `is_spoken: True` if the text is spoken.

