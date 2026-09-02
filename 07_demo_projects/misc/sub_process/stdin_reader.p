extends SceneTree;

TextEdit te;

Thread t = Thread.new();

void _initialize() {
	OS.low_processor_usage_mode = true;
	PanelContainer pc = PanelContainer.new();
	root.add_child(pc);
	pc.set_anchors_and_margins_preset(Control.PRESET_WIDE);
	
	te = TextEdit.new();
	pc.add_child(te);
	
//	t.start(this, @"_thread_func", this);
	t.start(this, @"_thread_func_read_data", this);
}

void exit() {
	t.wait_to_finish();
	quit();
}

void add_text(String stdinr) {
	te.text += stdinr;
}

static void _thread_func(Variant data) {
	SceneTree self = data;
	
	while (true) {
		// This will not work on windows, as read_string_from_stdin will
		// only grap user input, not pipes
		String stdinr = OS.read_string_from_stdin();
		
		print(stdinr);
		
		if (stdinr == "EOF") {
			self.call_deferred(@"exit");
			return;
		}
		
		// Ugly, but is fine for a simple demo
		self.call_deferred(@"add_text", stdinr);
	}
}

// uses read_data_from_stdin
static void _thread_func_read_data(Variant data) {
	SceneTree self = data;
	
	while (true) {
		PoolByteArray stdindata = OS.read_data_from_stdin();
		
		if (stdindata.size() == 0) {
			// Sleep a bit
			OS.delay_msec(10);
			continue;
		}
		
		// IF the data was written using write_to_stdin() it's going to be
		// utf8 on linux, utf16 on windows.
		String stdinr = stdindata.get_string_from_utf8();
//		String stdinr = stdindata.get_string_from_utf16();
//		String stdinr = stdindata.get_string_from_utf32();
		print(stdindata);
		print(stdinr);
		
		if (stdinr == "EOF") {
			self.call_deferred(@"exit");
			return;
		}
		
		// Ugly, but is fine for a simple demo
		self.call_deferred(@"add_text", stdinr);
	}
}

