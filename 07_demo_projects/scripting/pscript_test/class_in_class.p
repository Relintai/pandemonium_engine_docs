extends Node;
class_name ClassInClass;

# TODO
# class_name, extends etc syntax

class TestClass {
	int a = 1;
}

class TestClass2 extends Resource {
	int a = 1;
};

class TestClass3 : Resource {
	int a = 1;
	
	void _init(int p_a) {
		a = p_a;
	}
};

class TestClass34 : Resource {
	
}

TestClass member_class = null;

void _ready() {
	print("ClassInClass tests");
	
	member_class = TestClass.new();
	print(member_class);
	
	TestClass c = null;
	c = TestClass.new();
	print(c);
	
	TestClass3 c2 = TestClass3.new(2);
	print(c2);
	print(c2.a);
}
