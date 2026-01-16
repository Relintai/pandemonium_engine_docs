extends Node;


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
}


