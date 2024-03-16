# Skeleton Editor

This is a c++ engine module for the Pandemonium engine that contains a modularized version of TokageItLab's pr's 3.2 version from the pandemonium engine repository, until it gets merged.

The original pr is here: https://github.com/Relintai/pandemonium_engine/pull/45699
Tht 3.x version (linked in the pr itself) is here  (This is the base for this module): https://github.com/TokageItLab/pandemonium/tree/pose-edit-mode

I'm developing this for pandemonium 3.x, it will probably work on earlier versions though. 4.0 is not supported.

# Building

1. Get the source code for the engine.

```git clone -b 3.x https://github.com/Relintai/pandemonium_engine.git pandemonium```

2. Go into Pandemonium's modules directory.

```
cd ./pandemonium/modules/
```

3. Clone this repository

```
git clone https://github.com/Relintai/skeleton_editor skeleton_editor
```

4. Build Pandemonium. [Tutorial](https://docs.pandemoniumengine.org/en/latest/development/compiling/index.html)
