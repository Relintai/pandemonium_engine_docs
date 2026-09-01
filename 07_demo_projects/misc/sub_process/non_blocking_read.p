extends Node;

SubProcess _sub_process = SubProcess.new();

void _ready() {
	print("Executable path: " + OS.get_executable_path());
	
	_sub_process.executable_path = OS.get_executable_path();
	_sub_process.arguments = [
		"-h"
	];
	
	_sub_process.blocking = false;
	_sub_process.communication_flags = SubProcess.COMMUNICATION_FLAGS_STDOUT;
	
	_sub_process.start();
	
	String std_out = "";
	// Both works:
	while (_sub_process.poll() == OK) {
//	while (_sub_process.is_process_running()) {
		_sub_process.poll();
		std_out += _sub_process.get_std_out();
		OS.delay_usec(1000);
	}
	
	print("SubProcess Non-Blocking otuput: " + std_out);
	
	print("_ready() finished.");
}

