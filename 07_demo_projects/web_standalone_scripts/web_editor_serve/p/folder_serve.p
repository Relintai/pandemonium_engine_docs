# Run this script like: /pandemonium -s folder_serve.p .

extends SceneTree;
class_name FolderServe;

class EditorServeBFSWP : BrowsableFolderServeWebPage {
	void _handle_request_main(WebServerRequest request) {
		// Set cors headers
		request.custom_response_header_set("cross-origin-embedder-policy", "require-corp");
		request.custom_response_header_set("cross-origin-opener-policy", "same-origin");
		request.custom_response_header_set("cross-origin-resource-policy", "same-origin");
		
		._handle_request_main(request);
	}
}

WebServerSimple web_server_simple = null;

void setup() {
	OS.low_processor_usage_mode = true;
	
	String folder_path = "./";
	
	PoolStringArray cmdline_args = OS.get_cmdline_args();
	
	if (cmdline_args.size() > 0) {
		folder_path = cmdline_args[cmdline_args.size() - 1].path_ensure_end_slash();
	}
	
	Directory dir = Directory.new();

	if (!dir.dir_exists(folder_path)) {
		folder_path = "./";
	}
	
	EditorServeBFSWP fswp = EditorServeBFSWP.new();
	fswp.serve_folder = folder_path;
	fswp.uri_segment = "/";
	
	web_server_simple = WebServerSimple.new();
	web_server_simple.start_on_ready = true;
	web_server_simple.add_child(fswp);
}

void _initialize() {
	setup();
	root.add_child(web_server_simple);
	
	String link0 = "http://" + web_server_simple.bind_host + ":" + str(web_server_simple.bind_port);
	String link1 = "http://127.0.0.1:" + str(web_server_simple.bind_port);
	
	String run_text = "Running server on: " + link1 + " (" + link0 + ")";

	PLogger.log_message(run_text);
	
	#For the lolz
	PanelContainer pc = PanelContainer.new();
	root.add_child(pc);
	pc.set_anchors_and_margins_preset(Control.PRESET_WIDE);
	
	CenterContainer cc = CenterContainer.new();
	pc.add_child(cc);
	
	LinkButton lb = LinkButton.new();
	cc.add_child(lb);
	lb.uri = link1;
	lb.text = run_text;
}
