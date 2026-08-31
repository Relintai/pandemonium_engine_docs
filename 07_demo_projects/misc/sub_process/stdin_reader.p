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
	
	t.start(this, @"_thread_func", this);
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
