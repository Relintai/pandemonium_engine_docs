extends SceneTree;

TextEdit te;

Thread t = Thread.new();

void _initialize() {
//	OS.envir
	print("PATH: " + OS.get_environment("PATH"));
	print("TEST1: " + OS.get_environment("TEST1"));
	print("TEST2: " + OS.get_environment("TEST2"));
	print("HOME: " + OS.get_environment("HOME"));
	print("USER: " + OS.get_environment("USER"));


	call_deferred(@"quit");
}



