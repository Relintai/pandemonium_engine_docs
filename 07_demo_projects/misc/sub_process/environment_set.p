extends Node;

SubProcess _sub_process = SubProcess.new();

void _ready() {
	print("Executable path: " + OS.get_executable_path());
	
	# This will only work from the editor
	String path = ProjectSettings.globalize_path("res://environment_reader.p");

	print("Running script from: " + path);
	
	_sub_process.executable_path = OS.get_executable_path();
	_sub_process.arguments = [
		"-s",
		path,
	];
	
	_sub_process.blocking = true;
//	_sub_process.open_console = true;
//	_sub_process.communication_flags = SubProcess.COMMUNICATION_FLAGS_READ;
//	_sub_process.communication_flags = SubProcess.COMMUNICATION_FLAGS_NONE;
	_sub_process.communication_flags = SubProcess.COMMUNICATION_FLAGS_STDOUT;
//	_sub_process.use_pipe_mutex = true;

	// Vanilla run
	print("Vanilla run");

	_sub_process.start();
	print("1. SubProcess stdout: " + _sub_process.get_std_out());
	print("1. SubProcess stderr: " + _sub_process.get_std_err());
	_sub_process.stop();
	
	// Set vars
	print("Set vars");
	
	_sub_process.set_environment_variable(@"TEST1", "T");
	_sub_process.set_environment_variable(@"TEST2", "T2");
	
	_sub_process.start();
	print("2. SubProcess otuput: " + _sub_process.get_std_out());
	print("2. SubProcess stderr: " + _sub_process.get_std_err());
	_sub_process.stop();

	// Override Builtin Var
	print("Override Builtin Var");
	
	_sub_process.set_environment_variable(@"HOME", "TestHome");
	
	_sub_process.start();
	print("3. SubProcess otuput: " + _sub_process.get_std_out());
	print("3. SubProcess stderr: " + _sub_process.get_std_err());
	_sub_process.stop();
	
	// Unset Override Builtin Var
	print("Unset Override Builtin Var");
	
	_sub_process.unset_environment_variable(@"HOME");
	
	_sub_process.start();
	print("4. SubProcess otuput: " + _sub_process.get_std_out());
	print("4. SubProcess stderr: " + _sub_process.get_std_err());
	_sub_process.stop();
	
	// Unset Override Builtin Var
	print("Unset Override Builtin Var");
	
	_sub_process.unset_environment_variable(@"HOME");
	
	_sub_process.start();
	print("4. SubProcess otuput: " + _sub_process.get_std_out());
	print("4. SubProcess stderr: " + _sub_process.get_std_err());
	_sub_process.stop();
	
	// No inherit
	print("No inherit");
	
	_sub_process.inherit_environment = false;
	
	_sub_process.start();
	print("4. SubProcess otuput: " + _sub_process.get_std_out());
	print("4. SubProcess stderr: " + _sub_process.get_std_err());
	_sub_process.stop();
	
	print("_ready() finished.");
}

