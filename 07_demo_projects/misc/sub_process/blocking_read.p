extends Node;

SubProcess _sub_process = SubProcess.new();

void _ready() {
	print("Executable path: " + OS.get_executable_path());
	
	_sub_process.executable_path = OS.get_executable_path();
	_sub_process.arguments = [
		"-h"
	];
	
	_sub_process.blocking = true;
	_sub_process.communication_flags = SubProcess.COMMUNICATION_FLAGS_STDOUT;
	
	_sub_process.start();
	
	print("SubProcess otuput: " + _sub_process.get_std_out());
	
	print("_ready() finished.");
}

