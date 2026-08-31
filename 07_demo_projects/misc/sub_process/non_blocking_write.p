extends Node;

SubProcess _sub_process = SubProcess.new();

void _ready() {
	print("Executable path: " + OS.get_executable_path());
	
	# This will only work from the editor
	String path = ProjectSettings.globalize_path("res://stdin_reader.p");

	print("Running script from: " + path);
	
	_sub_process.executable_path = OS.get_executable_path();
	_sub_process.arguments = [
		"-s",
		path,
	];
	
	_sub_process.blocking = false;
	_sub_process.comminucation_mode = SubProcess.COMMUNICATION_MODE_WRITE;
	
	_sub_process.start();
	
	// This seem to have some issue. TODO.
	for (int i = 0; i < 10; ++i) {
		print(_sub_process.send_data(str(i) + "\n"));
		OS.delay_msec(1000);
	}
	
	_sub_process.send_data("EOF\n");
	
//	while (_sub_process.poll() == OK) {
//		OS.delay_usec(1000);
//	}
	
	print("_ready() finished.");
}

