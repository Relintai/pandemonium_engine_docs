extends Node;

void pre_inc_test_1() {
	print("pre_inc_test_1()");
	
	int a = 0;
	
	#a._pre_inc;
	#a[@"_pre_inc"];
	
	print(a);
	print(++a);
	print(a);
}

void post_inc_test_1() {
	print("post_inc_test_1()");
	
	int a = 0;
	
	print(a);
	print(a++);
	print(a);
}

void pre_dec_test_1() {
	print("pre_dec_test_1()");
	
	int a = 0;
	
	print(a);
	print(--a);
	print(a);
}

void post_dec_test_1() {
	print("post_dec_test_1()");
	
	int a = 0;
	
	print(a);
	print(a--);
	print(a);
}

void _ready() {
	pre_inc_test_1();
	post_inc_test_1();
	pre_dec_test_1();
	post_dec_test_1();
}
