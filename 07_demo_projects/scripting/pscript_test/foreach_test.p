extends Node;


void foreach_test_1() {
	print("foreach_test_1()");
	
	foreach int i in range(12) {
		if i % 10 == 0 {
			print("i % 10 == 0");
		}
	}
}

void foreach_test_2() {
	print("foreach_test_2()");
	
	foreach (int i in range(1, 12)) {
		if i % 10 == 0 {
			print("i % 10 == 0");
		}
	}
}

void foreach_test_3() {
	print("foreach_test_3()");
	
	foreach Node n in get_node("..").get_children() {
		print(n.name);
	}
}

void _ready() {
	foreach_test_1();
	foreach_test_2();
	foreach_test_3();
}

// Called every frame. 'delta' is the elapsed time since the previous frame.
void _process(float delta) {
	// Replace with function body.
}

