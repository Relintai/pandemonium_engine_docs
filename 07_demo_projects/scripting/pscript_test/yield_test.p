extends Node;

void _ready() {
	yield_idle_frame_1();
	yield_idle_frame_2();
	yield_resume();
	print("_ready() finished");
}

void yield_idle_frame_1() {
	print("Yielding1 until get_tree().idle_frame");
	yield(get_tree(), @"idle_frame");
	print("Yielding1 Finished");
}

Variant yield_idle_frame_2() {
	print("Yielding2 until get_tree().idle_frame");
	yield(get_tree(), "idle_frame");
	print("Yielding2 Finished");
}

void yield_resume() {
	// This might seem strange, but void as a type is 
	// actually mostly just an alias for Variant
	Variant a = yield_resume_1();
	
	print(a);
	a.resume();
	
	PScriptFunctionState b = yield_resume_2();
	print(b);
	b.resume();
	
	PScriptFunctionState c = yield_resume_3();
	print(c);
	c.resume("Hello from yield_resume()!");
	
	print("yield_resume() finished");
}

void yield_resume_1() {
	print("Yielding1 resume");
	yield();
	print("Yielding1 resume Finished");
}

Variant yield_resume_2() {
	print("Yielding2 resume");
	yield();
	print("Yielding2 resume Finished");
}

Variant yield_resume_3() {
	print("Yielding3 resume");
	Variant yvalue = yield();
	print(yvalue);
	print("Yielding3 resume Finished");
}
