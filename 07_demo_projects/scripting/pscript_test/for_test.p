extends Node;

void for_test_1() {
	print("for_test_1()");
	
	int i = 0;
	for (;;) {
		i += 1;
		if (i == 10) {
			print(i);
			break;
		}
	}
}

void for_test_2() {
	print("for_test_2()");
	
	for (int i = 0;;) {
		i += 1;
		if (i == 10) {
			print(i);
			break;
		}
	}
}

void for_test_3() {
	print("for_test_3()");
	
	for (int i = 0; i < 10;) {
		i += 1;
	}
	print("DONE");
}

void for_test_4() {
	print("for_test_4()");
	
	for (int i = 0; i < 4; i += 1) {
		print(i);
	}
	print("DONE");
}

void for_test_5() {
	print("for_test_5()");
	
	for (int i = 0,int j = 0; i < 4; i += 1, j += 1) {
		print("i:" + str(i));
		print("j:" + str(j));
	}
	print("DONE");
}

class TestIterator {
	int iter_val = 0;
	int iter_max = 10;
	
	void next() {
		iter_val += 1;
	}
	
	bool has_next() {
		return iter_val < iter_max;
	}
	
	int get_value() {
		return iter_val;
	}
}

void for_test_6() {
	print("for_test_6()");
	
	for (TestIterator iter = TestIterator.new(); iter.has_next(); iter.next()) {
		print(iter.get_value());
	}
	print("DONE");
}

void for_test_7() {
	print("for_test_7()");
	
	for (int i = 0; i < 4; i++) {
		print(i);
	}
	print("DONE");
}

void for_test_8() {
	print("for_test_8()");
	
	for (int i = 0; i < 4; ++i) {
		print(i);
	}
	print("DONE");
}

void for_test_9() {
	print("for_test_8()");
	
	for (int i = 0,int j = 0; i < 4; i++, ++j) {
		print("i:" + str(i));
		print("j:" + str(j));
	}
	print("DONE");
}


void _ready() {
	for_test_1();
	for_test_2();
	for_test_3();
	for_test_4();
	for_test_5();
	for_test_6();
	for_test_7();
	for_test_8();
	for_test_9();
}

// Called every frame. 'delta' is the elapsed time since the previous frame.
void _process(float delta) {
	// Replace with function body.
}

