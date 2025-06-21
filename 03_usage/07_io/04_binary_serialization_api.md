
# Binary serialization API

## Introduction

Pandemonium has a simple serialization API based on Variant. It's used for
converting data types to an array of bytes efficiently. This API is used
in the functions `get_var` and `store_var` of `File`
as well as the packet APIs for `PacketPeer`. This format
is *not* used for binary scenes and resources.

## Packet specification

The packet is designed to be always padded to 4 bytes. All values are
little-endian-encoded. All packets have a 4-byte header representing an
integer, specifying the type of data.

The lowest value two bytes are used to determine the type, while the highest value
two bytes contain flags

```
base_type = val & 0xFFFF;
flags = val >> 16;
```

| Type   | Value                    |
|--------|--------------------------|
| 0      | null                     |
| 1      | bool                     |
| 2      | integer                  |
| 3      | real                     |
| 4      | string                   |
| 5      | rect2                    |
| 6      | rect2i                   |
| 7      | vector2                  |
| 8      | vector2i                 |
| 9      | vector3                  |
| 10     | vector3i                 |
| 11     | vector4                  |
| 12     | vector4i                 |
| 13     | plane                    |
| 14     | quaternion               |
| 15     | aabb                     |
| 16     | basis                    |
| 17     | transform                |
| 18     | transform2d              |
| 19     | projection               |
| 20     | color                    |
| 21     | node path                |
| 22     | rid                      |
| 23     | object                   |
| 24     | string name              |
| 25     | dictionary               |
| 26     | array                    |
| 27     | raw array                |
| 28     | int array                |
| 29     | real array               |
| 30     | string array             |
| 31     | vector2 array            |
| 32     | vector2i array           |
| 33     | vector3 array            |
| 34     | vector3i array           |
| 35     | vector4 array            |
| 36     | vector4i array           |
| 37     | color array              |
| 38     | max                      |

Following this is the actual packet contents, which varies for each type of
packet. Note that this assumes Pandemonium is compiled with single-precision floats,
which is the default. If Pandemonium was compiled with double-precision floats, the
length of "Float" fields within data structures should be 8, and the offset
should be `(offset - 4) * 2 + 4`. The "float" type itself always uses double
precision.


### 0: null

Nothing

### 1: bool

| Offset   | Len   | Type      | Description               |
|----------|-------|-----------|---------------------------|
| 4        | 4     | Integer   | 0 for False, 1 for True   |

### 2: int

If no flags are set (flags == 0), the integer is sent as a 32 bit integer:

| Offset   | Len   | Type      | Description              |
|----------|-------|-----------|--------------------------|
| 4        | 4     | Integer   | 32-bit signed integer    |

If flag `ENCODE_FLAG_64` is set (`flags & 1 == 1`), the integer is sent as
a 64-bit integer:

| Offset   | Len   | Type      | Description              |
|----------|-------|-----------|--------------------------|
| 4        | 8     | Integer   | 64-bit signed integer    |

### 3: real (float or double)

If no flags are set (flags == 0), the float is sent as a 32 bit single precision:

| Offset   | Len   | Type    | Description                       |
|----------|-------|---------|-----------------------------------|
| 4        | 4     | Float   | IEEE 754 single-precision float   |

If flag `ENCODE_FLAG_64` is set (`flags & 1 == 1`), the float is sent as
a 64-bit double precision number:

| Offset   | Len   | Type    | Description                       |
|----------|-------|---------|-----------------------------------|
| 4        | 8     | Float   | IEEE 754 double-precision float   |

### 4: String

| Offset   | Len   | Type      | Description                |
|----------|-------|-----------|----------------------------|
| 4        | 4     | Integer   | String length (in bytes)   |
| 8        | X     | Bytes     | UTF-8 encoded string       |

This field is padded to 4 bytes.

### 5: Rect2

| Offset   | Len   | Type    | Description    |
|----------|-------|---------|----------------|
| 4        | 4     | Float   | X coordinate   |
| 8        | 4     | Float   | Y coordinate   |
| 12       | 4     | Float   | X size         |
| 16       | 4     | Float   | Y size         |

### 6: Rect2i

| Offset   | Len   | Type    | Description    |
|----------|-------|---------|----------------|
| 4        | 4     | Integer | X coordinate   |
| 8        | 4     | Integer | Y coordinate   |
| 12       | 4     | Integer | X size         |
| 16       | 4     | Integer | Y size         |

### 7: Vector2

| Offset   | Len   | Type    | Description    |
|----------|-------|---------|----------------|
| 4        | 4     | Float   | X coordinate   |
| 8        | 4     | Float   | Y coordinate   |

### 8: Vector2i

| Offset   | Len   | Type    | Description    |
|----------|-------|---------|----------------|
| 4        | 4     | Integer | X coordinate   |
| 8        | 4     | Integer | Y coordinate   |

### 9: Vector3

| Offset   | Len   | Type    | Description    |
|----------|-------|---------|----------------|
| 4        | 4     | Float   | X coordinate   |
| 8        | 4     | Float   | Y coordinate   |
| 12       | 4     | Float   | Z coordinate   |

### 10: Vector3i

| Offset   | Len   | Type    | Description    |
|----------|-------|---------|----------------|
| 4        | 4     | Integer | X coordinate   |
| 8        | 4     | Integer | Y coordinate   |
| 12       | 4     | Integer | Z coordinate   |

### 11: Vector4

| Offset   | Len   | Type    | Description    |
|----------|-------|---------|----------------|
| 4        | 4     | Float   | X coordinate   |
| 8        | 4     | Float   | Y coordinate   |
| 12       | 4     | Float   | Z coordinate   |
| 16       | 4     | Float   | W coordinate   |

### 12: Vector4i

| Offset   | Len   | Type    | Description    |
|----------|-------|---------|----------------|
| 4        | 4     | Integer | X coordinate   |
| 8        | 4     | Integer | Y coordinate   |
| 12       | 4     | Integer | Z coordinate   |
| 16       | 4     | Integer | W coordinate   |

### 13: Plane

| Offset   | Len   | Type    | Description   |
|----------|-------|---------|---------------|
| 4        | 4     | Float   | Normal X      |
| 8        | 4     | Float   | Normal Y      |
| 12       | 4     | Float   | Normal Z      |
| 16       | 4     | Float   | Distance      |

### 14: Quaternion

| Offset   | Len   | Type    | Description   |
|----------|-------|---------|---------------|
| 4        | 4     | Float   | Imaginary X   |
| 8        | 4     | Float   | Imaginary Y   |
| 12       | 4     | Float   | Imaginary Z   |
| 16       | 4     | Float   | Real W        |

### 15: AABB

| Offset   | Len   | Type    | Description    |
|----------|-------|---------|----------------|
| 4        | 4     | Float   | X coordinate   |
| 8        | 4     | Float   | Y coordinate   |
| 12       | 4     | Float   | Z coordinate   |
| 16       | 4     | Float   | X size         |
| 20       | 4     | Float   | Y size         |
| 24       | 4     | Float   | Z size         |

### 16: Basis

| Offset   | Len   | Type    | Description                                                   |
|----------|-------|---------|---------------------------------------------------------------|
| 4        | 4     | Float   | The X component of the X column vector, accessed via [0][0]   |
| 8        | 4     | Float   | The Y component of the X column vector, accessed via [0][1]   |
| 12       | 4     | Float   | The Z component of the X column vector, accessed via [0][2]   |
| 16       | 4     | Float   | The X component of the Y column vector, accessed via [1][0]   |
| 20       | 4     | Float   | The Y component of the Y column vector, accessed via [1][1]   |
| 24       | 4     | Float   | The Z component of the Y column vector, accessed via [1][2]   |
| 28       | 4     | Float   | The X component of the Z column vector, accessed via [2][0]   |
| 32       | 4     | Float   | The Y component of the Z column vector, accessed via [2][1]   |
| 36       | 4     | Float   | The Z component of the Z column vector, accessed via [2][2]   |

### 17: Transform

| Offset   | Len   | Type    | Description                                                   |
|----------|-------|---------|---------------------------------------------------------------|
| 4        | 4     | Float   | The X component of the X column vector, accessed via [0][0]   |
| 8        | 4     | Float   | The Y component of the X column vector, accessed via [0][1]   |
| 12       | 4     | Float   | The Z component of the X column vector, accessed via [0][2]   |
| 16       | 4     | Float   | The X component of the Y column vector, accessed via [1][0]   |
| 20       | 4     | Float   | The Y component of the Y column vector, accessed via [1][1]   |
| 24       | 4     | Float   | The Z component of the Y column vector, accessed via [1][2]   |
| 28       | 4     | Float   | The X component of the Z column vector, accessed via [2][0]   |
| 32       | 4     | Float   | The Y component of the Z column vector, accessed via [2][1]   |
| 36       | 4     | Float   | The Z component of the Z column vector, accessed via [2][2]   |
| 40       | 4     | Float   | The X component of the origin vector, accessed via [3][0]     |
| 44       | 4     | Float   | The Y component of the origin vector, accessed via [3][1]     |
| 48       | 4     | Float   | The Z component of the origin vector, accessed via [3][2]     |

### 18: Transform2D

| Offset   | Len   | Type    | Description                                                   |
|----------|-------|---------|---------------------------------------------------------------|
| 4        | 4     | Float   | The X component of the X column vector, accessed via [0][0]   |
| 8        | 4     | Float   | The Y component of the X column vector, accessed via [0][1]   |
| 12       | 4     | Float   | The X component of the Y column vector, accessed via [1][0]   |
| 16       | 4     | Float   | The Y component of the Y column vector, accessed via [1][1]   |
| 20       | 4     | Float   | The X component of the origin vector, accessed via [2][0]     |
| 24       | 4     | Float   | The Y component of the origin vector, accessed via [2][1]     |


### 19: Projection

| Offset   | Len   | Type    | Description                                                   |
|----------|-------|---------|---------------------------------------------------------------|
| 4        | 4     | Float   | The X component of the X column vector, accessed via [0][0]   |
| 8        | 4     | Float   | The Y component of the X column vector, accessed via [0][1]   |
| 12       | 4     | Float   | The Z component of the X column vector, accessed via [0][2]   |
| 16       | 4     | Float   | The W component of the X column vector, accessed via [0][3]   |
| 20       | 4     | Float   | The X component of the Y column vector, accessed via [1][0]   |
| 24       | 4     | Float   | The Y component of the Y column vector, accessed via [1][1]   |
| 28       | 4     | Float   | The Z component of the Y column vector, accessed via [1][2]   |
| 32       | 4     | Float   | The W component of the Y column vector, accessed via [1][3]   |
| 36       | 4     | Float   | The X component of the Z column vector, accessed via [2][0]   |
| 40       | 4     | Float   | The Y component of the Z column vector, accessed via [2][1]   |
| 44       | 4     | Float   | The Z component of the Z column vector, accessed via [2][2]   |
| 48       | 4     | Float   | The W component of the Z column vector, accessed via [2][3]   |
| 52       | 4     | Float   | The X component of the W column vector, accessed via [3][0]   |
| 56       | 4     | Float   | The Y component of the W column vector, accessed via [3][1]   |
| 60       | 4     | Float   | The Z component of the W column vector, accessed via [3][2]   |
| 64       | 4     | Float   | The W component of the W column vector, accessed via [3][3]   |

### 20: Color

| Offset   | Len   | Type    | Description                                                  |
|----------|-------|---------|--------------------------------------------------------------|
| 4        | 4     | Float   | Red (typically 0..1, can be above 1 for overbright colors)   |
| 8        | 4     | Float   | Green (typically 0..1, can be above 1 for overbright colors) |
| 12       | 4     | Float   | Blue (typically 0..1, can be above 1 for overbright colors)  |
| 16       | 4     | Float   | Alpha (0..1)                                                 |

### 21: NodePath

| Offset   | Len   | Type      | Description                                                                             |
|----------|-------|-----------|-----------------------------------------------------------------------------------------|
| 4        | 4     | Integer   | String length, or new format (val&0x80000000!=0 and NameCount=val&0x7FFFFFFF)           |

#### For old format:

| Offset   | Len   | Type    | Description            |
|----------|-------|---------|------------------------|
| 8        | X     | Bytes   | UTF-8 encoded string   |

Padded to 4 bytes.

#### For new format:

| Offset   | Len   | Type      | Description                         |
|----------|-------|-----------|-------------------------------------|
| 4        | 4     | Integer   | Sub-name count                      |
| 8        | 4     | Integer   | Flags (absolute: val&1 != 0 )       |

For each Name and Sub-Name

| Offset   | Len   | Type      | Description            |
|----------|-------|-----------|------------------------|
| X+0      | 4     | Integer   | String length          |
| X+4      | X     | Bytes     | UTF-8 encoded string   |

Every name string is padded to 4 bytes.

### 22: RID

unsupported

### 23: Object

Unsupported

### 24: StringName

Encoded as Strings.

### 25: Dictionary

| Offset   | Len   | Type      | Description                                                         |
|----------|-------|-----------|---------------------------------------------------------------------|
| 4        | 4     | Integer   | val&0x7FFFFFFF = elements, val&0x80000000 = shared (bool)           |

Then what follows is, for amount of "elements", pairs of key and value,
one after the other, using this same format.

### 26: Array

| Offset   | Len   | Type      | Description                                                         |
|----------|-------|-----------|---------------------------------------------------------------------|
| 4        | 4     | Integer   | val&0x7FFFFFFF = elements, val&0x80000000 = shared (bool)           |

Then what follows is, for amount of "elements", values one after the
other, using this same format.

### 27: PoolByteArray


| Offset        | Len   | Type      | Description            |
|---------------|-------|-----------|------------------------|
| 4             | 4     | Integer   | Array length (Bytes)   |
| 8..8+length   | 1     | Byte      | Byte (0..255)          |

The array data is padded to 4 bytes.

### 28: PoolIntArray

| Offset           | Len   | Type      | Description               |
|------------------|-------|-----------|---------------------------|
| 4                | 4     | Integer   | Array length (Integers)   |
| 8..8+length\*4   | 4     | Integer   | 32-bit signed integer     |

### 29: PoolRealArray

| Offset           | Len   | Type      | Description               |
|------------------|-------|-----------|---------------------------|
| 4                | 4     | Integer   | Array length (Floats)     |
| 8..8+length\*4   | 4     | Integer   | 32-bits IEEE 754 float    |

### 30: PoolStringArray

| Offset   | Len   | Type      | Description              |
|----------|-------|-----------|--------------------------|
| 4        | 4     | Integer   | Array length (Strings)   |

For each String:

| Offset   | Len   | Type      | Description            |
|----------|-------|-----------|------------------------|
| X+0      | 4     | Integer   | String length          |
| X+4      | X     | Bytes     | UTF-8 encoded string   |

Every string is padded to 4 bytes.

### 31: PoolVector2Array

| Offset            | Len   | Type      | Description    |
|-------------------|-------|-----------|----------------|
| 4                 | 4     | Integer   | Array length   |
| 8..8+length\*8    | 4     | Float     | X coordinate   |
| 8..12+length\*8   | 4     | Float     | Y coordinate   |

### 32: PoolVector2iArray

| Offset            | Len   | Type      | Description    |
|-------------------|-------|-----------|----------------|
| 4                 | 4     | Integer   | Array length   |
| 8..8+length\*8    | 4     | Integer   | X coordinate   |
| 8..12+length\*8   | 4     | Integer   | Y coordinate   |

### 33: PoolVector3Array

| Offset             | Len   | Type      | Description    |
|--------------------|-------|-----------|----------------|
| 4                  | 4     | Integer   | Array length   |
| 8..8+length\*12    | 4     | Float     | X coordinate   |
| 8..12+length\*12   | 4     | Float     | Y coordinate   |
| 8..16+length\*12   | 4     | Float     | Z coordinate   |

### 34: PoolVector3iArray

| Offset             | Len   | Type      | Description    |
|--------------------|-------|-----------|----------------|
| 4                  | 4     | Integer   | Array length   |
| 8..8+length\*12    | 4     | Integer   | X coordinate   |
| 8..12+length\*12   | 4     | Integer   | Y coordinate   |
| 8..16+length\*12   | 4     | Integer   | Z coordinate   |


### 35: PoolVector4Array

| Offset             | Len   | Type      | Description    |
|--------------------|-------|-----------|----------------|
| 4                  | 4     | Integer   | Array length   |
| 8..8+length\*12    | 4     | Float     | X coordinate   |
| 8..12+length\*12   | 4     | Float     | Y coordinate   |
| 8..16+length\*12   | 4     | Float     | Z coordinate   |
| 8..16+length\*16   | 4     | Float     | W coordinate   |

### 36: PoolVector4iArray

| Offset             | Len   | Type      | Description    |
|--------------------|-------|-----------|----------------|
| 4                  | 4     | Integer   | Array length   |
| 8..8+length\*12    | 4     | Integer   | X coordinate   |
| 8..12+length\*12   | 4     | Integer   | Y coordinate   |
| 8..16+length\*12   | 4     | Integer   | Z coordinate   |
| 8..16+length\*16   | 4     | Integer   | W coordinate   |

### 37: PoolColorArray

| Offset             | Len   | Type      | Description                                                  |
|--------------------|-------|-----------|--------------------------------------------------------------|
| 4                  | 4     | Integer   | Array length                                                 |
| 8..8+length\*16    | 4     | Float     | Red (typically 0..1, can be above 1 for overbright colors)   |
| 8..12+length\*16   | 4     | Float     | Green (typically 0..1, can be above 1 for overbright colors) |
| 8..16+length\*16   | 4     | Float     | Blue (typically 0..1, can be above 1 for overbright colors)  |
| 8..20+length\*16   | 4     | Float     | Alpha (0..1)                                                 |

