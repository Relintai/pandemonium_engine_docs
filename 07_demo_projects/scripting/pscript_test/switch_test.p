extends Node;


void switch_test_1() {
	print("switch_test_1()");

	Variant x = 1;

	switch x {
	case 1: 
		print("We are number one!");
		break;
	case 2:
		print("Two are better than one!");
		break;
	}
}

void switch_test_2() {
	print("switch_test_2()");
	
	int x = 1;

	switch (x) {
	case (1): 
		print("We are number one!");
	case (2):
		print("Two are better than one!");
	}
}

void switch_test_3() {
	print("switch_test_3()");

	Variant x = 2;

	switch x {
	case 1: {
		print("We are number one!");
		break;
	}
	case 2: {
		print("Two are better than one!");
		break;
	}
	}
}

void switch_test_4() {
	print("switch_test_4()");

	Variant x = 1;

	switch x {
	case 1:
		print("We are number one!");
	case 2:
		print("Two are better than one!");
	default:
		print("Default!");
	}
}

void switch_test_5() {
	print("switch_test_5()");

	int x = 14;

	switch x {
	case 1:
		print("We are number one!");
		break;
	case 2:
		print("Two are better than one!");
		break;
	case 3:
		print("Three are better than one!");
		break;
	case 4:
		print("4 are better than one!");
		break;
	case 5:
		print("5 are better than one!");
		break;
	case 6:
		print("6 are better than one!");
		break;
	default:
		print("Default are better than one!");
	}
}

void switch_test_6() {
	print("switch_test_6()");

	Variant x = 2;

	switch x {
	case 1:
		print("We are number one!");
		break;
	case 2:
		print("Two are better than one!");
		break;
	case 3:
		print("Three are better than one!");
	default:
		print("Default are better than one!");
	}
}

void switch_test_7() {
	print("switch_test_7()");

	Variant x = 2;

	switch x {
	case 1:
		print("We are number one!");
		break;
	case 2:
		print("Two are better than one!");
		break;
	case 3:
		print("Three are better than one!");
		break;
	default:
		print("Default are better than one!");
	}
}

void _ready() {
	switch_test_1();
	switch_test_2();
	switch_test_3();
	switch_test_4();
	switch_test_5();
	switch_test_6();
	switch_test_7();
}

// Called every frame. 'delta' is the elapsed time since the previous frame.
void _process(float delta) {
	// Replace with function body.
}

