# Run this script like: /pandemonium -s folder_serve.gd .

extends SceneTree
class_name FolderServe

class EditorServeBFSWP:
	extends BrowsableFolderServeWebPage
	
	func _handle_request_main(request : WebServerRequest) -> void:
		# Set cors headers
		request.custom_response_header_set("cross-origin-embedder-policy", "require-corp");
		request.custom_response_header_set("cross-origin-opener-policy", "same-origin");
		request.custom_response_header_set("cross-origin-resource-policy", "same-origin");
		
		._handle_request_main(request);


var web_server_simple : WebServerSimple = null

func setup():
	OS.low_processor_usage_mode = true
	
	var folder_path : String = "./"
	
	var cmdline_args : PoolStringArray = OS.get_cmdline_args()
	
	if cmdline_args.size() > 0:
		folder_path = cmdline_args[cmdline_args.size() - 1].path_ensure_end_slash()
	
	var dir : Directory = Directory.new()

	if !dir.dir_exists(folder_path):
		folder_path = "./"
	
	var fswp : EditorServeBFSWP = EditorServeBFSWP.new()
	fswp.serve_folder = folder_path
	fswp.uri_segment = "/"
	
	web_server_simple = WebServerSimple.new()
	web_server_simple.start_on_ready = true
	web_server_simple.add_child(fswp)

func _initialize():
	setup()
	root.add_child(web_server_simple)
	
	var link0 : String = "http://" + web_server_simple.bind_host + ":" + str(web_server_simple.bind_port)
	var link1 : String = "http://127.0.0.1:" + str(web_server_simple.bind_port)
	
	var run_text : String = "Running server on: " + link1 + " (" + link0 + ")"

	PLogger.log_message(run_text)
	
	#For the lolz
	var pc : PanelContainer = PanelContainer.new()
	root.add_child(pc)
	pc.set_anchors_and_margins_preset(Control.PRESET_WIDE)
	
	var cc : CenterContainer = CenterContainer.new()
	pc.add_child(cc)
	
	var lb : LinkButton = LinkButton.new()
	cc.add_child(lb)
	lb.uri = link1
	lb.text = run_text

