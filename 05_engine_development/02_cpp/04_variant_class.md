

# Variant class

## About

Variant is the most important datatype of Pandemonium, it's the most important
class in the engine. A Variant takes up only 20 bytes and can store
almost any engine datatype inside of it. Variants are rarely used to
hold information for long periods of time, instead they are used mainly
for communication, editing, serialization and generally moving data
around.

A Variant can:

-  Store almost any datatype
-  Perform operations between many variants (GDScript uses Variant as
   its atomic/native datatype).
-  Be hashed, so it can be compared quickly to other variants
-  Be used to convert safely between datatypes
-  Be used to abstract calling methods and their arguments (Pandemonium
   exports all its functions through variants)
-  Be used to defer calls or move data between threads.
-  Be serialized as binary and stored to disk, or transferred via
   network.
-  Be serialized to text and use it for printing values and editable
   settings.
-  Work as an exported property, so the editor can edit it universally.
-  Be used for dictionaries, arrays, parsers, etc.

Basically, thanks to the Variant class, writing Pandemonium itself was a much,
much easier task, as it allows for highly dynamic constructs not common
of C++ with little effort. Become a friend of Variant today.

### References:

-  [core/variant.h](https://github.com/Relintai/pandemonium_engine/blob/3.x/core/variant.h)

## Containers: Dictionary and Array

Both are implemented using variants. A Dictionary can match any datatype
used as key to any other datatype. An Array just holds an array of
Variants. Of course, a Variant can also hold a Dictionary and an Array
inside, making it even more flexible.

Modifications to a container will modify all references to
it. A Mutex should be created to lock it if multi threaded access is
desired.

Copy-on-write (COW) mode support for containers was dropped with Pandemonium 3.0.

### References:

-  [core/dictionary.h](https://github.com/Relintai/pandemonium_engine/blob/3.x/core/dictionary.h)
-  [core/array.h](https://github.com/Relintai/pandemonium_engine/blob/3.x/core/array.h)

