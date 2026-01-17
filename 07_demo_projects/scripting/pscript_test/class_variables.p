extends Node;

# Some normal variables
int var_int_1;
int var_int_2 = 1;

Variant var_variant_1;
Variant var_variant_2 = 1;
Variant var_variant_3 = "";

Array arr_1;
Array arr_2 = Array();
Array arr_3 = [ 1, 2, 3, 4 ];
Array arr_4 = [ 
		[ 1, 2, 3, 4],
		[ 1, 2, 3, 4]
	];

Dictionary dict_1;
Dictionary dict_2 = Dictionary();
Dictionary dict_3 = |{ 1: "Test1", 2: "Test2" }|;
Dictionary dict_4 = |{ 
		1: "Test1",
		2: "Test2"
	}|;

# This is just variant
# TODO should this be allowed? Technically it makes sense, it just looks strange at first. It's like a void *.
void var_void_1;
void var_void_2 = 1;
void var_void_3 = "";

# Note that setters and getters don't get called from the inside (This is how gdscript works aswell)
# Thats why it won't print getter and setter strings.
# Switch to remote scene after running, and select this node
int var_int_3 = 33 setget set_test_3;
int var_int_4 = 55 setget set_test_4, get_test_4;
int var_int_5 = 66 setget , get_test_5;

#onready

onready Node main_node = get_node("..");
onready Node main_node2 = $"..";

onready Control control = get_node("TestControl") as Control;
onready Control control2 = $TestControl;
onready Control control3 = $TestControl as Control;

# exports

export(int) int exp_int_1;
export(int) int exp_int_2 = 33;
export(int) int exp_int_3 = 33 setget set_test_export_int, get_test_export_int;

export(String) String test_string_1;
export(String) String test_string_2 = "TEST";

export(Array) Array test_array_1;
export(Array) Array test_array_2 = Array();
export(Array, Mesh) Array test_array_3;
export(Array, Mesh) Array test_array_4 = Array();

export(TypedArray) TypedArray test_typed_array_1 = TypedArray("int");
export(TypedArray) TypedArray test_typed_array_2 = TypedArray("Mesh");

export(PackedTypedArray) PackedTypedArray test_packed_typed_array_1 = PackedTypedArray("int");
export(PackedTypedArray) PackedTypedArray test_packed_typed_array_2 = PackedTypedArray("Mesh");

export(Texture) Texture tex_exp_1;
export(Texture) Texture tex_exp_2 = null;

# Just newline

export(Texture)
Texture tex_exp_3;

export(Texture)
Texture tex_exp_4 = null;

# ; and newline

export(Texture);
Texture tex_exp_5;

export(Texture);
Texture tex_exp_6 = null;

# Constants
const Variant TEST_CONST_1 = 1;
const int TEST_CONST_2 = 1;
const String TEST_CONST_3 = "ASD";

# TODO Decide if this is needed:
"asdasdS"

"""
asdasd
asd
asdasd
"""

void set_test_3(int value) {
	var_int_3 = value;
	print("set_test_3" + str(var_int_3));
}

int get_test_4() {
	print("get_test_4()" + str(var_int_4));
	return var_int_4;
}

void set_test_4(int value) {
	var_int_4 = value;
	print("set_test_4()" + str(var_int_4));
}

int get_test_5() {
	print("get_test_5()" + str(var_int_5));
	return var_int_5;
}

int get_test_export_int() {
	print("get_test_export_int()" + str(exp_int_3));
	return exp_int_3;
}

void set_test_export_int(int value) {
	exp_int_3 = value;
	print("set_test_export_int()" + str(exp_int_3));
}

void _ready() {
	print("Exports and variables tests");
	
	print(var_int_1);
	print(var_int_2);
	
	var_int_3 = 11;
	print(var_int_4);
	var_int_4 = 156;
	print(var_int_5);
}

