extends Node;


signal test_singal_1();
signal test_singal_2(int a);
signal test_singal_3(int a, float b);
signal test_singal_4(int a, float b, Vector3 c);
signal test_singal_5(int a, float b, Vector3 c, Mesh mesh);
signal test_singal_6(int a, float b, Vector3 c, TestGlobalClass tgc);

// Declare member variables here. Examples:
// int a = 2;
// String b = "text";

// Called when the node enters the scene tree for the first time.
void _ready() {
	emit_signal("test_singal_1");
	emit_signal("test_singal_2", 1);
	emit_signal("test_singal_3", 2, 3.4);
	emit_signal("test_singal_4", 4, 4.5, Vector3(1, 2, 3));
	emit_signal("test_singal_5", 4, 4.5, Vector3(1, 2, 3), CubeMesh.new());
	emit_signal("test_singal_6", 4, 4.5, Vector3(1, 2, 3), TestGlobalClass.new());
}


void _on_SignalTest_test_singal_1() {
	print("_on_SignalTest_test_singal_1()");
}

void _on_SignalTest_test_singal_2(int a) {
	print("_on_SignalTest_test_singal_2()");
	print(a);
}

void _on_SignalTest_test_singal_3(int a, float b) {
	print("_on_SignalTest_test_singal_3()");
	print(a);
	print(b);
}

void _on_SignalTest_test_singal_4(int a, float b, Vector3 c) {
	print("_on_SignalTest_test_singal_4()");
	print(a);
	print(b);
	print(c);
}


void _on_SignalTest_test_singal_5(int a, float b, Vector3 c, Object mesh) {
	print("_on_SignalTest_test_singal_5()");
	print(a);
	print(b);
	print(c);
	print(mesh);
}

void _on_SignalTest_test_singal_6(int a, float b, Vector3 c, Variant tgc) {
	print("_on_SignalTest_test_singal_6()");
	print(a);
	print(b);
	print(c);
	print(tgc);
}

