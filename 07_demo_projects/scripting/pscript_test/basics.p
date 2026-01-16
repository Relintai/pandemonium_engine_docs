extends Node;

#export(String): String varname = "";   ?

#export(String);  <- use # as like a preprocessor symbol ?
#String varname = "";

#[export(String)]    ?   <- This should be easy to handle in _parse_class() 
#String varname = "";

#export(String)    ?  <- support newline, and make newline optional?
#String varname = "";

func empty_method() -> void {
}

func while_loop_test_1() -> void {
	var i : int = 0;
	
	while (i < 10) {
		i += 1;
	}
	
	print("while_loop_test 1: " + str(i));
}

func while_loop_test_2() -> void {
	var i : int = 0;
	
	while (i < 20) {
		i += 1;
	}
	
	print("while_loop_test 2: " + str(i));
}


func for_loop_test_1() -> void {
	var c : int = 0;
	
	for i in range(10) {
		c += 1;
	}
	
	print("for_loop_test 1: " + str(c));
}

func for_loop_test_2() -> void {
	var c : int = 0;
	
	for i in range(10) {
		c += 1;
	}
	
	print("for_loop_test 2: " + str(c));
}

func for_loop_test_3() -> void {
	var c : int = 0;
	
	for i in range(10) {
		for j in range(10) {
			c += 1;
		}
	}
	
	print("for_loop_test 3: " + str(c));
}

func if_test_1() -> void {
	var b : bool = true;
	
	if b {
		print("if_test_1 OK");
	}
}

func if_test_2() -> void {
	var b : bool = true;
	
	if (b) {
		print("if_test_2 OK");
	}
}

func if_test_3() -> void {
	var b : int = 10;
	
	if (b < 33) {
		print("if_test_3 OK");
	}
}

func if_else_test_1() -> void {
	var b : bool = true;
	
	if b {
		print("if_else_test_1 OK1");
	} else {
		print("if_else_test_1 OK2");
	}
}


func if_else_test_2() -> void {
	var b : bool = true;
	
	if (b) {
		print("if_else_test_2 OK1");
	} else {
		print("if_else_test_2 OK2");
	}
}

func if_else_test_3() -> void {
	var b : int = 44;
	
	if (b == 44) {
		print("if_else_test_2 OK1");
	} else {
		print("if_else_test_2 OK2");
	}
}

func else_if_test_1() -> void {
	var b : int = 10;
	
	if b == 10 {
		print("else_if_test_1 OK");
	} elif b == 11 {
		print("else_if_test_1 NOK");
	} elif b == 12 {
		print("else_if_test_1 NOK");
	}
}

func else_if_test_2() -> void {
	var b : int = 10;
	
	if (b == 10) {
		print("else_if_test_2 OK");
	} elif (b == 11) {
		print("else_if_test_2 NOK");
	} elif (b == 12) {
		print("else_if_test_2 NOK");
	}
}

func else_if_else_test_1() -> void {
	var b : int = 10;
	
	if b == 10 {
		print("else_if_else_test_1 OK");
	} elif b == 11 {
		print("else_if_else_test_1 NOK");
	} elif b == 12 {
		print("else_if_else_test_1 NOK");
	} else {
		
	}
}

func else_if_else_test_2() -> void {
	var b : int = 10;
	
	if (b == 10) {
		print("else_if_else_test_2 OK");
	} elif (b == 11) {
		print("else_if_else_test_2 NOK");
	} elif (b == 12) {
		print("else_if_else_test_2 NOK");
	} else {
		print("else_if_else_test_2 NOK");
	}
}


func else_if_else_test_3() -> void {
	var b : int = 10;
	
	if (b == 10) {
		print("else_if_else_test_2 OK");
	} 
	elif (b == 11) 
	{
		print("else_if_else_test_2 NOK");
	} elif (b == 12) 
	{
		print("else_if_else_test_2 NOK");
	} 
	
	else 
	{
		print("else_if_else_test_2 NOK");
	}
}

func this_test() -> void {
	print("This: " + str(this));
}

func return_test_1() -> int {
	return 10;
}

func return_test_2() -> String {
	return "A";
}

func return_test_3() -> Variant {
	return 1;
}

func return_test_4() -> Variant {
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


func return_test() -> void {
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

void method_args_tests() {
	print(method_args_test_1(12));
	print(method_args_test_2(165));
	print(method_args_test_3(165, "String!"));
	print(method_args_test_4(165, "String!", 113.5));
	print(method_args_test_5(165, "String!"));
	print(method_args_test_6(165));
	print(method_args_test_7(165));
}

func _ready() -> void {
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
}


void _enter_tree() {
	print("ENTER TREE from new method syntax!!");
}
