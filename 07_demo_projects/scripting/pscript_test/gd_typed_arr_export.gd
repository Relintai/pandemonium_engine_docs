extends Node;

export(TypedArray) var test_typed_array_1 : TypedArray = TypedArray("int");
export(TypedArray) var test_typed_array_2 : TypedArray = TypedArray("Mesh");
export(TypedArray) var test_typed_array_3 : TypedArray = TypedArray("TestGlobalClass");
export(TypedArray, "TestGlobalClass") var test_typed_array_5 : TypedArray<TestGlobalClass> = TypedArray("TestGlobalClass");
export(TypedArray, @"TestGlobalClass") var test_typed_array_6 : TypedArray<TestGlobalClass> = TypedArray("TestGlobalClass");
export(TypedArray, TestGlobalClass) var test_typed_array_7 : TypedArray<TestGlobalClass> = TypedArray("TestGlobalClass");
export(TypedArray, int) var test_typed_array_8 : TypedArray<int> = TypedArray("int");
export(TypedArray, int) var test_typed_array_10 : TypedArray<int> = TypedArray<int>();
export(TypedArray, Mesh) var test_typed_array_11 : TypedArray<Mesh> = TypedArray<Mesh>();
export(TypedArray, TestGlobalClass) var test_typed_array_12 : TypedArray<TestGlobalClass> = TypedArray<TestGlobalClass>();
export(TypedArray, TestGlobalClass) var test_typed_array_13 : TypedArray<TestGlobalClass> = TypedArray<TestGlobalClass>();


export(PackedTypedArray) var test_packed_typed_array_1 : PackedTypedArray = PackedTypedArray("int");
export(PackedTypedArray) var test_packed_typed_array_2 : PackedTypedArray = PackedTypedArray("Mesh");
export(PackedTypedArray) var test_packed_typed_array_3 : PackedTypedArray = PackedTypedArray("TestGlobalClass");
export(PackedTypedArray, "TestGlobalClass") var test_packed_typed_array_4 : PackedTypedArray<TestGlobalClass> = PackedTypedArray("TestGlobalClass");
export(PackedTypedArray, @"TestGlobalClass") var test_packed_typed_array_5 : PackedTypedArray<TestGlobalClass> = PackedTypedArray("TestGlobalClass");
export(PackedTypedArray, TestGlobalClass) var test_packed_typed_array_6 : PackedTypedArray<TestGlobalClass> = PackedTypedArray("TestGlobalClass");
export(PackedTypedArray, int) var test_packed_typed_array_7 : PackedTypedArray<int> = PackedTypedArray("int");
export(PackedTypedArray, int, 1) var test_packed_typed_array_8 : PackedTypedArray<int, 1> = PackedTypedArray("int", 1);
export(PackedTypedArray, int, INT_TYPE_UNSIGNED_16) var test_packed_typed_array_9 : PackedTypedArray<int, INT_TYPE_UNSIGNED_16> = PackedTypedArray("int", PackedTypedArray.INT_TYPE_UNSIGNED_16);
export(PackedTypedArray, int) var test_packed_typed_array_10 : PackedTypedArray<int> = PackedTypedArray<int>();
export(PackedTypedArray, Mesh) var test_packed_typed_array_11 : PackedTypedArray<Mesh> = PackedTypedArray<Mesh>();
export(PackedTypedArray, TestGlobalClass) var test_packed_typed_array_12 : PackedTypedArray<TestGlobalClass> = PackedTypedArray<TestGlobalClass>();
export(PackedTypedArray, TestGlobalClass) var test_packed_typed_array_13 : PackedTypedArray<TestGlobalClass> = PackedTypedArray<TestGlobalClass>();
export(PackedTypedArray, int) var test_packed_typed_array_14 : PackedTypedArray<int> = PackedTypedArray<int>();
export(PackedTypedArray, int, INT_TYPE_SIGNED_64) var test_packed_typed_array_15 : PackedTypedArray<int, INT_TYPE_SIGNED_64> = PackedTypedArray<int, INT_TYPE_SIGNED_64>();
export(PackedTypedArray, int) var test_packed_typed_array_16 : PackedTypedArray<int> = PackedTypedArray<int>();


# TypedArrays

func typed_array_hint_test_1() -> TypedArray<Mesh>:
	var arr : TypedArray<Mesh> = TypedArray(@"Mesh");
	
	return arr;

func typed_array_hint_test_2() -> TypedArray<int>:
	var arr : TypedArray<int> = TypedArray(@"int");

	return arr;

#func typed_array_hint_test_3() -> TypedArray<Mesh>:
#	var arr : TypedArray<int> = TypedArray(@"int");
#
#	return arr;

#func typed_array_hint_test_4() -> TypedArray<int>:
#	var arr : TypedArray<int> = TypedArray(@"Mesh");
#
#	return arr;

func typed_array_hint_test_5() -> TypedArray<int>:
	var arr : TypedArray<int> = TypedArray<int>();

	return arr;
	
