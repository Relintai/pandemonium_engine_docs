

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
| 3      | float                    |
| 4      | string                   |
| 5      | vector2                  |
| 6      | rect2                    |
| 7      | vector3                  |
| 8      | transform2d              |
| 9      | plane                    |
| 10     | quat                     |
| 11     | aabb                     |
| 12     | basis                    |
| 13     | transform                |
| 14     | color                    |
| 15     | node path                |
| 16     | rid                      |
| 17     | object                   |
| 18     | dictionary               |
| 19     | array                    |
| 20     | raw array                |
| 21     | int array                |
| 22     | real array               |
| 23     | string array             |
| 24     | vector2 array            |
| 25     | vector3 array            |
| 26     | color array              |
| 27     | max                      |

Following this is the actual packet contents, which varies for each type of
packet. Note that this assumes Pandemonium is compiled with single-precision floats,
which is the default. If Pandemonium was compiled with double-precision floats, the
length of "Float" fields within data structures should be 8, and the offset
should be `(offset - 4) * 2 + 4`. The "float" type itself always uses double
precision.

### 0: null

### 1: `bool( bool )`

| Offset   | Len   | Type      | Description               |
|----------|-------|-----------|---------------------------|
| 4        | 4     | Integer   | 0 for False, 1 for True   |

### 2: `int( int )`

If no flags are set (flags == 0), the integer is sent as a 32 bit integer:

| Offset   | Len   | Type      | Description              |
|----------|-------|-----------|--------------------------|
| 4        | 4     | Integer   | 32-bit signed integer    |

If flag `ENCODE_FLAG_64` is set (`flags & 1 == 1`), the integer is sent as
a 64-bit integer:

| Offset   | Len   | Type      | Description              |
|----------|-------|-----------|--------------------------|
| 4        | 8     | Integer   | 64-bit signed integer    |

### 3: `float( float )`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If no flags are set (flags == 0), the float is sent as a 32 bit single precision:

| Offset   | Len   | Type    | Description                       |
|----------|-------|---------|-----------------------------------|
| 4        | 4     | Float   | IEEE 754 single-precision float   |

If flag `ENCODE_FLAG_64` is set (`flags & 1 == 1`), the float is sent as
a 64-bit double precision number:

| Offset   | Len   | Type    | Description                       |
|----------|-------|---------|-----------------------------------|
| 4        | 8     | Float   | IEEE 754 double-precision float   |

### 4: `String( string )`

| Offset   | Len   | Type      | Description                |
|----------|-------|-----------|----------------------------|
| 4        | 4     | Integer   | String length (in bytes)   |
| 8        | X     | Bytes     | UTF-8 encoded string       |

This field is padded to 4 bytes.

### 5: `Vector2( vector2 )`

| Offset   | Len   | Type    | Description    |
|----------|-------|---------|----------------|
| 4        | 4     | Float   | X coordinate   |
| 8        | 4     | Float   | Y coordinate   |

### 6: `Rect2( rect2 )`

| Offset   | Len   | Type    | Description    |
|----------|-------|---------|----------------|
| 4        | 4     | Float   | X coordinate   |
| 8        | 4     | Float   | Y coordinate   |
| 12       | 4     | Float   | X size         |
| 16       | 4     | Float   | Y size         |

### 7: `Vector3( vector3 )`


| Offset   | Len   | Type    | Description    |
|----------|-------|---------|----------------|
| 4        | 4     | Float   | X coordinate   |
| 8        | 4     | Float   | Y coordinate   |
| 12       | 4     | Float   | Z coordinate   |

### 8: `Transform2D( transform2d )`

| Offset   | Len   | Type    | Description                                                   |
|----------|-------|---------|---------------------------------------------------------------|
| 4        | 4     | Float   | The X component of the X column vector, accessed via [0][0]   |
| 8        | 4     | Float   | The Y component of the X column vector, accessed via [0][1]   |
| 12       | 4     | Float   | The X component of the Y column vector, accessed via [1][0]   |
| 16       | 4     | Float   | The Y component of the Y column vector, accessed via [1][1]   |
| 20       | 4     | Float   | The X component of the origin vector, accessed via [2][0]     |
| 24       | 4     | Float   | The Y component of the origin vector, accessed via [2][1]     |

### 9: `Plane( plane )`

| Offset   | Len   | Type    | Description   |
|----------|-------|---------|---------------|
| 4        | 4     | Float   | Normal X      |
| 8        | 4     | Float   | Normal Y      |
| 12       | 4     | Float   | Normal Z      |
| 16       | 4     | Float   | Distance      |


### 10: `Quat( quat )`


| Offset   | Len   | Type    | Description   |
|----------|-------|---------|---------------|
| 4        | 4     | Float   | Imaginary X   |
| 8        | 4     | Float   | Imaginary Y   |
| 12       | 4     | Float   | Imaginary Z   |
| 16       | 4     | Float   | Real W        |


### 11: `AABB( aabb )`


| Offset   | Len   | Type    | Description    |
|----------|-------|---------|----------------|
| 4        | 4     | Float   | X coordinate   |
| 8        | 4     | Float   | Y coordinate   |
| 12       | 4     | Float   | Z coordinate   |
| 16       | 4     | Float   | X size         |
| 20       | 4     | Float   | Y size         |
| 24       | 4     | Float   | Z size         |


### 12: `Basis( basis )`


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


### 13: `Transform( transform )`


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

### 14: `Color( color )`


| Offset   | Len   | Type    | Description                                                  |
|----------|-------|---------|--------------------------------------------------------------|
| 4        | 4     | Float   | Red (typically 0..1, can be above 1 for overbright colors)   |
| 8        | 4     | Float   | Green (typically 0..1, can be above 1 for overbright colors) |
| 12       | 4     | Float   | Blue (typically 0..1, can be above 1 for overbright colors)  |
| 16       | 4     | Float   | Alpha (0..1)                                                 |


### 15: `NodePath( nodepath )`

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

### 16: `RID( rid )` (unsupported)

### 17: `Object( object )` (unsupported)

### 18: `Dictionary( dictionary )`

| Offset   | Len   | Type      | Description                                                         |
|----------|-------|-----------|---------------------------------------------------------------------|
| 4        | 4     | Integer   | val&0x7FFFFFFF = elements, val&0x80000000 = shared (bool)           |

Then what follows is, for amount of "elements", pairs of key and value,
one after the other, using this same format.

### 19: `Array( array )`

| Offset   | Len   | Type      | Description                                                         |
|----------|-------|-----------|---------------------------------------------------------------------|
| 4        | 4     | Integer   | val&0x7FFFFFFF = elements, val&0x80000000 = shared (bool)           |

Then what follows is, for amount of "elements", values one after the
other, using this same format.

### 20: `PoolByteArray( poolbytearray )`


| Offset        | Len   | Type      | Description            |
|---------------|-------|-----------|------------------------|
| 4             | 4     | Integer   | Array length (Bytes)   |
| 8..8+length   | 1     | Byte      | Byte (0..255)          |

The array data is padded to 4 bytes.

### 21: `PoolIntArray( poolintarray )`


| Offset           | Len   | Type      | Description               |
|------------------|-------|-----------|---------------------------|
| 4                | 4     | Integer   | Array length (Integers)   |
| 8..8+length\*4   | 4     | Integer   | 32-bit signed integer     |

### 22: `PoolRealArray( poolrealarray )`

| Offset           | Len   | Type      | Description               |
|------------------|-------|-----------|---------------------------|
| 4                | 4     | Integer   | Array length (Floats)     |
| 8..8+length\*4   | 4     | Integer   | 32-bits IEEE 754 float    |

### 23: `PoolStringArray( poolstringarray )`

| Offset   | Len   | Type      | Description              |
|----------|-------|-----------|--------------------------|
| 4        | 4     | Integer   | Array length (Strings)   |

For each String:


| Offset   | Len   | Type      | Description            |
|----------|-------|-----------|------------------------|
| X+0      | 4     | Integer   | String length          |
| X+4      | X     | Bytes     | UTF-8 encoded string   |


Every string is padded to 4 bytes.

### 24: `PoolVector2Array( poolvector2array )`


| Offset            | Len   | Type      | Description    |
|-------------------|-------|-----------|----------------|
| 4                 | 4     | Integer   | Array length   |
| 8..8+length\*8    | 4     | Float     | X coordinate   |
| 8..12+length\*8   | 4     | Float     | Y coordinate   |


### 25: `PoolVector3Array( poolvector3array )`


| Offset             | Len   | Type      | Description    |
|--------------------|-------|-----------|----------------|
| 4                  | 4     | Integer   | Array length   |
| 8..8+length\*12    | 4     | Float     | X coordinate   |
| 8..12+length\*12   | 4     | Float     | Y coordinate   |
| 8..16+length\*12   | 4     | Float     | Z coordinate   |


### 26: `PoolColorArray( poolcolorarray )`


| Offset             | Len   | Type      | Description                                                  |
|--------------------|-------|-----------|--------------------------------------------------------------|
| 4                  | 4     | Integer   | Array length                                                 |
| 8..8+length\*16    | 4     | Float     | Red (typically 0..1, can be above 1 for overbright colors)   |
| 8..12+length\*16   | 4     | Float     | Green (typically 0..1, can be above 1 for overbright colors) |
| 8..16+length\*16   | 4     | Float     | Blue (typically 0..1, can be above 1 for overbright colors)  |
| 8..20+length\*16   | 4     | Float     | Alpha (0..1)                                                 |

