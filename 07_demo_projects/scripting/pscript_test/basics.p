extends Node;

# TODOs:

# foreach add type support
# C like for()
# /* */ multiline comment. They should probably be nestable. (Or have #if 0 and #if 1)
# Also think bout class_name, extends syntax, both foreach the main file class, and class inside class syntax
# Make Signal support types
# Require parenthesis around control flow statements?
# Rework match syntax, should probably be renamed to switch
# Simplify match
// In-class autocomplete should try to do Virtual methods by default
// Fix error printed when _ +shift spaace in a class

# # -> preprocessor directives?
# The tokenizer could preprocess the file before loading it
# #define, #define <value> ?
# #if #ifdef #else if (#eilf?) #else #endif ?
# #include <> ? Just copy paste a file in. Maybe .ph extension foreach p script header (just
# so the editor loads it as text file)? It should only get syntax highlighting
# C function like search and replace macros?
# Maybe this is overkill -> if not implemented, keep # as an alternate comment token

void empty_method() {

}

void while_loop_test_1() {
	
	# asdasd -> variable
	# asdasd() -> call
	# lookahead-> ( -> call, done
	# no call -> check if variable
	#asdasd.asdasd()
	
	
	#Color.antiquewhite == Color.aliceblue;
	
	#Array([ 1, 2, 3 ])
	
	#Array() == ;
	
	#AABB asd = AABB();
	
	int i = 0;
	
	while (i < 10) {
		i += 1;
	}
	
	print("while_loop_test 1: " + str(i));
}

void while_loop_test_2() {
	int i = 0;
	
	while (i < 20) {
		i += 1;
	}
	
	print("while_loop_test 2: " + str(i));
}


void for_loop_test_1() {
	int c = 0;
	
	foreach i in range(10) {
		c += 1;
	}
	
	print("for_loop_test 1: " + str(c));
}

void for_loop_test_2() {
	int c = 0;
	
	foreach i in range(10) {
		c += 1;
	}
	
	print("for_loop_test 2: " + str(c));
}

void for_loop_test_3() {
	int c = 0;
	
	foreach i in range(10) {
		foreach j in range(10) {
			c += 1;
		}
	}
	
	print("for_loop_test 3: " + str(c));
}

void if_test_1() {
	bool b = true;
	
	if b {
		print("if_test_1 OK");
	}
}

void if_test_2() {
	bool b = true;
	
	if (b) {
		print("if_test_2 OK");
	}
}

void if_test_3() {
	int b = 10;
	
	if (b < 33) {
		print("if_test_3 OK");
	}
}

void if_else_test_1() {
	bool b = true;
	
	if b {
		print("if_else_test_1 OK1");
	} else {
		print("if_else_test_1 OK2");
	}
}


void if_else_test_2() {
	bool b = true;
	
	if (b) {
		print("if_else_test_2 OK1");
	} else {
		print("if_else_test_2 OK2");
	}
}

void if_else_test_3() {
	int b = 44;
	
	if (b == 44) {
		print("if_else_test_2 OK1");
	} else {
		print("if_else_test_2 OK2");
	}
}

void else_if_test_1() {
	int b = 10;
	
	if b == 10 {
		print("else_if_test_1 OK");
	} else if b == 11 {
		print("else_if_test_1 NOK");
	} else if b == 12 {
		print("else_if_test_1 NOK");
	}
}

void else_if_test_2() {
	int b = 10;
	
	if (b == 10) {
		print("else_if_test_2 OK");
	} else if (b == 11) {
		print("else_if_test_2 NOK");
	} else if (b == 12) {
		print("else_if_test_2 NOK");
	}
}

void else_if_else_test_1() {
	int b = 10;
	
	if b == 10 {
		print("else_if_else_test_1 OK");
	} else if b == 11 {
		print("else_if_else_test_1 NOK");
	} else if b == 12 {
		print("else_if_else_test_1 NOK");
	} else {
		
	}
}

void else_if_else_test_2() {
	int b = 10;
	
	if (b == 10) {
		print("else_if_else_test_2 OK");
	} else if (b == 11) {
		print("else_if_else_test_2 NOK");
	} else if (b == 12) {
		print("else_if_else_test_2 NOK");
	} else {
		print("else_if_else_test_2 NOK");
	}
}


void else_if_else_test_3() {
	int b = 10;
	
	if (b == 10) {
		print("else_if_else_test_2 OK");
	} 
	else if (b == 11) 
	{
		print("else_if_else_test_2 NOK");
	} else if (b == 12) 
	{
		print("else_if_else_test_2 NOK");
	} 
	
	else 
	{
		print("else_if_else_test_2 NOK");
	}
}

void this_test() {
	print("This: " + str(this));
}

int return_test_1() {
	return 10;
}

String return_test_2() {
	return "A";
}

Variant return_test_3() {
	return 1;
}

Variant return_test_4() {
	return this;
}

int return_test_5() {
	return 10;
}

String return_test_6() {
	return "A";
}

Variant return_test_7() {
	return 1;
}

Variant return_test_8() {
	return this;
}


void return_test() {
	print(return_test_1());
	print(return_test_2());
	print(return_test_3());
	print(return_test_4());
	print(return_test_5());
	print(return_test_6());
	print(return_test_7());
	print(return_test_8());
}

void method_args_test_1(int a1) {
	print(a1);
}

String method_args_test_2(int a1) {
	return str(a1);
}

void method_args_test_3(int a1, String a2) {
	print(str(a1) + " " + a2);
}

String method_args_test_4(int a1, String a2, float a3) {
	return str(a1) + a2 + str(a3);
}

String method_args_test_5(int a1, String a2, float a3 = 13) {
	return str(a1) + a2 + str(a3);
}

String method_args_test_6(int a1, String a2 = "AAA", float a3 = 15) {
	return str(a1) + a2 + str(a3);
}

static String method_args_test_7(int a1, String a2 = "AAA", float a3 = 15) {
	return str(a1) + a2 + str(a3);
}

void variables_instacing_test() {
	print("variables_test():");
	
	ImageTexture tex = ImageTexture.new();
	print(tex);
}

void class_instacing_test() {
	print("class_instacing_test():");
	
	TestGlobalClass tgc = null;
	print(tgc);
	tgc = TestGlobalClass.new();
	print(tgc);
	
	print("TGC2");
	TestGlobalClass tgc2 = TestGlobalClass.new();
	print(tgc2);
	
	print("TIC1");
	ClassInClass::TestClass c = null;
	c = ClassInClass.TestClass.new();
	print(c);
	
	print("TIC2");
	ClassInClass::TestClass c2 = ClassInClass::TestClass.new();
	print(c2);
}

void raw_block_1() {
	int i = 0;
	
	{
		int j = 0;
		j += 1;
		print("empty_block(): " + str(j) + " " + str(i));
	}
	
	#j += 3;
}

void raw_block_2() {
	HTMLBuilder b = HTMLBuilder.new();
	
	b.div();
	{
		b.a().href("127.0.0.1").f().w("Some Link").ca();
	}
	b.cdiv();
	
	b.div(); {
		b.a().href("127.0.0.1").f().w("Some Link 2").ca();
	} b.cdiv();
	
	b.write_tag();
	
	print("raw_block_2(): " + b.result);
}

# Match
#TODO (_parse_pattern, and _parse_pattern_block, _transform_match_statment and more)

void method_args_tests() {
	print(method_args_test_1(12));
	print(method_args_test_2(165));
	print(method_args_test_3(165, "String!"));
	print(method_args_test_4(165, "String!", 113.5));
	print(method_args_test_5(165, "String!"));
	print(method_args_test_6(165));
	print(method_args_test_7(165));
}

void _ready() {
	while_loop_test_1();
	while_loop_test_2();
	for_loop_test_1();
	for_loop_test_2();
	for_loop_test_3();
	if_test_1();
	if_test_2();
	if_test_3();
	if_else_test_1();
	if_else_test_2();
	if_else_test_3();
	else_if_test_1();
	else_if_test_2();
	else_if_else_test_1();
	else_if_else_test_2();
	else_if_else_test_3();
	this_test();
	return_test();
	
	method_args_tests();
	
	variables_instacing_test();
	class_instacing_test();
	
	raw_block_1();
	raw_block_2();
}


void _enter_tree() {
	print("ENTER TREE from new method syntax!!");
}
