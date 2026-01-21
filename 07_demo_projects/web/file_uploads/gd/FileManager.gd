extends WebNode

export(bool) var render_back_arrow : bool = true
export(String) var serve_folder : String

enum EditActions {
	UPLOAD = 0,
	DELETE,
	CREATE_FOLDER,
	DELETE_FOLDER,
	#RENAME, TODO
}

var _file_cache : FileCache = FileCache.new()

func _ready():
	var dir : Directory = Directory.new()
	
	if !dir.dir_exists(serve_folder):
		dir.make_dir_recursive(serve_folder)
	
	_file_cache.set_wwwroot(serve_folder)
	PLogger.log_message("Serve folder set to: %s" % [ serve_folder ])

func _handle_request_main(request : WebServerRequest) -> void:
	if (web_permission):
		if (web_permission.activate(request)):
			return;
	
	if request.get_method() == HTTPServerEnums.HTTP_METHOD_POST:
		var target_folder_url : String = request.get_path(true, false);
		
		# This folder has to exist!
		var target_folder_abspath : String = _file_cache.wwwroot_get_folder_abspath(target_folder_url)
		
		# Folder does not exists!
		if target_folder_abspath.empty():
			PLogger.log_error("target_folder_abspath.empty() ! '{0}'".format([ target_folder_abspath ]))
			request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_404_NOT_FOUND)
			return
		
		var action : int = int(request.get_post_parameter("action"))
		
		if action == EditActions.UPLOAD:
			var file_name : String = request.get_file_file_name(0)
			
			if file_name.empty():
				PLogger.log_error("file_name.empty()!")
				request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_500_INTERNAL_SERVER_ERROR)
				return
			
			var file_path : String = target_folder_url.append_path(file_name)
			file_path = _file_cache.wwwroot_get_simplified_abs_path(file_path)
			
			if file_path.empty():
				PLogger.log_error("file_path.empty()!")
				request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_500_INTERNAL_SERVER_ERROR)
				return
			
			request.move_file(0, file_path, true)
			PLogger.log_message("File uploaded: %s" % file_path)
		elif action == EditActions.CREATE_FOLDER:
			var folder : String = request.get_post_parameter("folder")
			var new_folder_url : String = target_folder_url.append_path(folder)
			
			if _file_cache.wwwroot_path_exists(new_folder_url):
				PLogger.log_error("_file_cache.wwwroot_path_exists(new_folder_url) ! '{0}'".format([ new_folder_url ]))
				request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_500_INTERNAL_SERVER_ERROR)
				return
			
			if !folder.empty():
				var full_path : String = _file_cache.wwwroot_get_simplified_abs_path(new_folder_url)
				
				if full_path.empty():
					PLogger.log_error("full_path.empty()!")
					request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_500_INTERNAL_SERVER_ERROR)
					return
				
				var d : Directory = Directory.new()
				d.make_dir_recursive(full_path)
		elif action == EditActions.DELETE_FOLDER:
			var folder : String = request.get_post_parameter("folder")
			var new_folder_url : String = target_folder_url.append_path(folder)
			
			if !_file_cache.wwwroot_has_folder(new_folder_url):
				PLogger.log_error("!_file_cache.wwwroot_has_folder(new_folder_url) ! '{0}'".format([ new_folder_url ]))
				request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_500_INTERNAL_SERVER_ERROR)
				return
			
			if !folder.empty():
				var full_path : String = _file_cache.wwwroot_get_folder_abspath(new_folder_url)
				
				if full_path.empty():
					PLogger.log_error("full_path.empty()!")
					request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_500_INTERNAL_SERVER_ERROR)
					return
					
				var d : Directory = Directory.new()
				d.remove(full_path)
		elif action == EditActions.DELETE:
			var file : String = request.get_post_parameter("file")
			var file_uri_path : String = target_folder_url.append_path(file)
			
			if !_file_cache.wwwroot_has_file(file_uri_path):
					PLogger.log_error("!_file_cache.wwwroot_has_file(file_uri_path)")
					request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_500_INTERNAL_SERVER_ERROR)
					return

			if !file_uri_path.empty():
				var full_path : String = _file_cache.wwwroot_get_file_abspath(file_uri_path)
				
				if full_path.empty():
					PLogger.log_error("full_path.empty()!")
					request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_500_INTERNAL_SERVER_ERROR)
					return
					
				var d : Directory = Directory.new()
				d.remove(full_path)
	
	var rp : String = request.get_current_path_segment();

	if (rp.empty()):
		handle_request(request);
		return;

	var file_name : String = request.get_path(true, false);
	file_name = file_name.to_lower();
	
	var fabspath : String = _file_cache.wwwroot_get_file_abspath(file_name)

	if (!fabspath.empty()):
		request.send_file(fabspath);
		
		return;

	if (!try_route_request_to_children(request)):
		handle_request(request);

# This will only get called if we need a folder listing
func _handle_request(request : WebServerRequest):
	var target_folder_url : String = request.get_path(true, false);

	var target_folder_abspath : String = _file_cache.wwwroot_get_folder_abspath(target_folder_url)

	# Folder does not exists!
	if target_folder_abspath.empty():
		request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_404_NOT_FOUND);
		return
		
	render_menu(request);
	
	if render_back_arrow:
		var b : HTMLBuilder = HTMLBuilder.new()
		
		b.div("row mb-4")
		b.div("col-2")
		b.cdiv()
			
		b.div("col-8 pt-2 pb-2 panel_content")
		
		b.h4()
		b.a(get_full_uri_parent()).f().w("<--- back").ca()
		b.ch4()
		
		b.cdiv()
		
		b.div("col-2")
		b.cdiv()
		b.cdiv()
		
		b.write_tag()
		
		request.body += b.result

	request.body += evaluate_dir(request, target_folder_abspath, target_folder_url == "/")
	request.compile_and_send_body();


func evaluate_dir(request : WebServerRequest, path : String, top_level : bool = false) -> String:
	var dir : Directory = Directory.new()
	dir.open(path)
	
	var serve_folder_abspath : String = _file_cache.get_wwwroot_abs();

	var dir_uri : String

	if (!top_level):
		dir_uri = path.substr(serve_folder_abspath.length(), path.length() - serve_folder_abspath.length());
	else:
		dir_uri = "/";
		
	var folders : PoolStringArray = PoolStringArray()
	var files : PoolStringArray = PoolStringArray()

	dir.list_dir_begin(true);

	var file : String = dir.get_next();

	while !file.empty():
		var np : String = path.append_path(file);
		var nnp : String = np.substr(serve_folder_abspath.length(), np.length() - serve_folder_abspath.length());

		if (dir.current_is_dir()):
			folders.push_back(nnp);2
		else:
			files.push_back(nnp);

		file = dir.get_next();

	dir.list_dir_end();

	folders.sort();
	files.sort();

	return render_dir_page(request, dir_uri, folders, files, top_level);


func render_dir_page(request : WebServerRequest, dir_uri : String, folders : PoolStringArray, files : PoolStringArray, top_level : bool) -> String:
	var b : HTMLBuilder = HTMLBuilder.new()

	var uri : String = get_full_uri(false);
		
	if uri == "/":
		uri = ""

	#b.div("file_list");
	if true:
		if (!top_level):
			b.div("row").f().div("col-2").f().cdiv().div("col-8 pt-2 pb-2 panel_content")
			if true:
				b.a(uri + dir_uri.path_get_prev_dir()).f().w("..").ca();
			b.cdiv().div("col-2").f().cdiv().cdiv()
		

		for i in range(folders.size()):
			b.div("row").f().div("col-2").f().cdiv().div("col-8 pt-2 pb-2 panel_content")
			if true:
				b.form_post(uri + dir_uri, "form-inline")
				
				b.div("mr-5")
				b.a(uri + folders[i]).f().w("(Folder) ").w(folders[i].get_file()).ca();
				b.cdiv()
				
				if true:
					b.csrf_tokenr(request)
					b.input_hidden("action", str(EditActions.DELETE_FOLDER))
					b.input_hidden("folder", folders[i].get_file())
					b.input_submit("X")
				b.cform()
			b.cdiv().div("col-2").f().cdiv().cdiv()
		

		for i in range(files.size()):
			b.div("row").f().div("col-2").f().cdiv().div("col-8 pt-2 pb-2 panel_content")
			if true:
				b.form_post(uri + dir_uri, "form-inline")
				
				b.div("mr-5")
				b.a(uri + files[i]).f().w("(File) ").w(files[i].get_file()).ca();
				b.cdiv()
				
				if true:
					b.csrf_tokenr(request)
					b.input_hidden("action", str(EditActions.DELETE))
					b.input_hidden("file", files[i].get_file())
					b.input_submit("X")
				b.cform()
			b.cdiv().div("col-2").f().cdiv().cdiv()
			
		if folders.size() == 0 && files.size() == 0:
			b.div("row").f().div("col-2").f().cdiv().div("col-8 pt-2 pb-2 panel_content")
			if true:
				b.w("Directory is empty.")
			b.cdiv().div("col-2").f().cdiv().cdiv()
	
	#b.cdiv();
	
	b.div("row mt-4").f().div("col-2").f().cdiv().div("col-8 pt-2 pb-2 panel_content")
	b.w("Upload new file")
	b.cdiv().div("col-2").f().cdiv().cdiv()
	
	b.div("row").f().div("col-2").f().cdiv().div("col-8 pt-2 pb-2")
	b.form_post(uri + dir_uri).enctype_multipart_form_data()
	if true:
		b.csrf_tokenr(request)
		b.input_hidden("action", str(EditActions.UPLOAD))
		b.input_file("file")
		b.input_submit("Upload")
	b.cform()
	b.cdiv().div("col-2").f().cdiv().cdiv()
	
	b.div("row mt-4").f().div("col-2").f().cdiv().div("col-8 pt-2 pb-2 panel_content")
	b.w("Create new folder")
	b.cdiv().div("col-2").f().cdiv().cdiv()
	
	b.div("row").f().div("col-2").f().cdiv().div("col-8 pt-2 pb-2")
	b.form_post(uri + dir_uri)
	if true:
		b.csrf_tokenr(request)
		b.input_hidden("action", str(EditActions.CREATE_FOLDER))
		b.input_text("folder")
		b.input_submit("Create")
	b.cform()
	b.cdiv().div("col-2").f().cdiv().cdiv()
	
	b.write_tag()

	return b.result;

