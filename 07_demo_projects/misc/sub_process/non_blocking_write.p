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
	// If you only connect stdin, the 2 process's stdou will remain connected,
	// And you will see what's sent printed to the terminal by the receiving script.
	// it prints input print(stdinr);
	_sub_process.communication_flags = SubProcess.COMMUNICATION_FLAGS_STDIN;
//	_sub_process.communication_flags = SubProcess.COMMUNICATION_FLAGS_ALL;
//	_sub_process.use_pipe_mutex = true;
	
	_sub_process.start();
	
	print("Process id: " + str(_sub_process.get_process_id()));
	
	// This seem to have some issue. TODO.
	for (int i = 0; i < 10; ++i) {
		String data = str(i);
		print(str(data + "\n").to_utf8());
		// Only enable one, also change stdin_reader.p to match
//		print("Sent String: \"%s\" Result code: %d" % [ data, _sub_process.write_to_stdin(data + "\n") ]);  // enable utf8 on linux, utf16 on windows in stdin_reader.p
		print("Sent String: \"%s\" Result code: %d" % [ data, _sub_process.write_to_stdin_utf8(data + "\n") ]);
//		print("Sent String: \"%s\" Result code: %d" % [ data, _sub_process.write_to_stdin_utf16(data + "\n") ]);
//		print("Sent String: \"%s\" Result code: %d" % [ data, _sub_process.write_to_stdin_utf32(data + "\n") ]);
//		print("Sent String: \"%s\" Result code: %d" % [ data, _sub_process.write_data_to_stdin((data + "\n").to_utf8()) ]); // enable utf8 in stdin_reader.p
		OS.delay_msec(1000);
	}
	
	// Only enable one, also change stdin_reader.p to match. Active line need to match the one in for{}
//	print("Sent String: \"%s\" Result code: %d" % [ "EOF", _sub_process.write_to_stdin("EOF\n") ]); // enable utf8 on linux, utf16 on windows in stdin_reader.p
	print("Sent String: \"%s\" Result code: %d" % [ "EOF", _sub_process.write_to_stdin_utf8("EOF\n") ]);
//	print("Sent String: \"%s\" Result code: %d" % [ "EOF", _sub_process.write_to_stdin_utf16("EOF\n") ]);
//	print("Sent String: \"%s\" Result code: %d" % [ "EOF", _sub_process.write_to_stdin_utf32("EOF\n") ]);
//	print("Sent String: \"%s\" Result code: %d" % [ "EOF", _sub_process.write_data_to_stdin("EOF\n".to_utf8()) ]); // enable utf8 in stdin_reader.p
	
//	while (_sub_process.poll() == OK) {
//		OS.delay_usec(1000);
//	}
	
	print("_ready() finished.");
}

