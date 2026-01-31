extends Node;

void ref_func_test_1(Ref<Reference> p_ref) {
	print(p_ref);
}

void ref_func_test_2(Ref<Resource> p_res) {
	print(p_res);
}

void ref_func_test_3(const Ref<Reference> &p_ref) {
	print(p_ref);
}

void ref_func_test_4(const Ref<Resource> &p_res) {
	print(p_res);
}

void _ready() {
	print("Ref<> Tests");
	
	Ref<AStar> astar;
	astar = AStar.new();
	Ref<Image> img = Image.new();
	// Technically this is not correct, don't know if it matters though
	Ref<Object> obj;
	
	ref_func_test_1(astar);
	ref_func_test_2(img);
	ref_func_test_3(astar);
	ref_func_test_4(img);
}


