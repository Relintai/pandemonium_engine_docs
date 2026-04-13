extends Node;

export(TypedArray) var test_typed_array_1 : TypedArray = TypedArray("int");
export(TypedArray) var test_typed_array_2 : TypedArray = TypedArray("Mesh");
export(TypedArray) var test_typed_array_3 : TypedArray = TypedArray("TestGlobalClass");
export(TypedArray, "TestGlobalClass") var test_typed_array_5 : TypedArray = TypedArray("TestGlobalClass");
export(TypedArray, @"TestGlobalClass") var test_typed_array_6 : TypedArray = TypedArray("TestGlobalClass");
export(TypedArray, TestGlobalClass) var test_typed_array_7 : TypedArray = TypedArray("TestGlobalClass");
export(TypedArray, int) var test_typed_array_8 : TypedArray = TypedArray("int");

export(PackedTypedArray) var test_packed_typed_array_1 : PackedTypedArray = PackedTypedArray("int");
export(PackedTypedArray) var test_packed_typed_array_2 : PackedTypedArray = PackedTypedArray("Mesh");
export(PackedTypedArray) var test_packed_typed_array_3 : PackedTypedArray = PackedTypedArray("TestGlobalClass");
export(PackedTypedArray, "TestGlobalClass") var test_packed_typed_array_4 : PackedTypedArray = PackedTypedArray("TestGlobalClass");
export(PackedTypedArray, @"TestGlobalClass") var test_packed_typed_array_5 : PackedTypedArray = PackedTypedArray("TestGlobalClass");
export(PackedTypedArray, TestGlobalClass) var test_packed_typed_array_6 : PackedTypedArray = PackedTypedArray("TestGlobalClass");
export(PackedTypedArray, int) var test_packed_typed_array_7 : PackedTypedArray = PackedTypedArray("int");
export(PackedTypedArray, int, 1) var test_packed_typed_array_8 : PackedTypedArray = PackedTypedArray("int", 1);
export(PackedTypedArray, int, INT_TYPE_UNSIGNED_16) var test_packed_typed_array_9 : PackedTypedArray = PackedTypedArray("int", PackedTypedArray.INT_TYPE_UNSIGNED_16);

