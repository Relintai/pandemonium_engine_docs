extends Node;

SubProcess _sub_process = SubProcess.new();

void _ready() {
	print("Executable path: " + OS.get_executable_path());
	
	_sub_process.executable_path = OS.get_executable_path();
	_sub_process.arguments = [
		"-h"
	];
	
	_sub_process.blocking = false;
	_sub_process.comminucation_mode = SubProcess.COMMUNICATION_MODE_NONE;
	
	_sub_process.start();
	
	while (_sub_process.poll() == OK) {
		OS.delay_usec(1000);
	}
	
	print("_ready() finished.");
}

