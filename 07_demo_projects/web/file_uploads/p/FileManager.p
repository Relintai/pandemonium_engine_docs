extends WebNode;

export(bool) bool render_back_arrow = true;
export(String) String serve_folder;

enum EditActions {
	UPLOAD = 0,
	DELETE,
	CREATE_FOLDER,
	DELETE_FOLDER,
	#RENAME, TODO
};

FileCache _file_cache = FileCache.new();

void _ready() {
	Directory dir = Directory.new();
	
	if !dir.dir_exists(serve_folder) {
		dir.make_dir_recursive(serve_folder);
	}
	
	_file_cache.set_wwwroot(serve_folder);
	
	PLogger.log_message("Serve folder set to: %s" % [ serve_folder ]);
}

void _handle_request_main(WebServerRequest request) {
	if (web_permission) {
		if (web_permission.activate(request)) {
			return;
		}
	}
	
	if request.get_method() == HTTPServerEnums.HTTP_METHOD_POST {
		String target_folder_url = request.get_path(true, false);
		
		# This folder has to exist!
		String target_folder_abspath = _file_cache.wwwroot_get_folder_abspath(target_folder_url);
		
		# Folder does not exists!
		if target_folder_abspath.empty() {
			PLogger.log_error("target_folder_abspath.empty() ! '{0}'".format([ target_folder_abspath ]));
			request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_404_NOT_FOUND);
			return;
		}
		
		int action = int(request.get_post_parameter("action"));
		
		if action == EditActions.UPLOAD {
			String file_name = request.get_file_file_name(0);
			
			if file_name.empty() {
				PLogger.log_error("file_name.empty()!");
				request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_500_INTERNAL_SERVER_ERROR);
				return;
			}
			
			String file_path = target_folder_url.append_path(file_name);
			file_path = _file_cache.wwwroot_get_simplified_abs_path(file_path);
			
			if file_path.empty() {
				PLogger.log_error("file_path.empty()!");
				request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_500_INTERNAL_SERVER_ERROR);
				return;
			}
			
			request.move_file(0, file_path, true);
			PLogger.log_message("File uploaded: %s" % file_path);
		} else if action == EditActions.CREATE_FOLDER {
			String folder = request.get_post_parameter("folder");
			String new_folder_url = target_folder_url.append_path(folder);
			
			if _file_cache.wwwroot_path_exists(new_folder_url) {
				PLogger.log_error("_file_cache.wwwroot_path_exists(new_folder_url) ! '{0}'".format([ new_folder_url ]));
				request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_500_INTERNAL_SERVER_ERROR);
				return;
			}
			
			if !folder.empty() {
				String full_path = _file_cache.wwwroot_get_simplified_abs_path(new_folder_url);
				
				if full_path.empty() {
					PLogger.log_error("full_path.empty()!");
					request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_500_INTERNAL_SERVER_ERROR);
					return;
				}
				
				Directory d = Directory.new();
				d.make_dir_recursive(full_path);
			}
		} else if action == EditActions.DELETE_FOLDER {
			String folder = request.get_post_parameter("folder");
			String new_folder_url = target_folder_url.append_path(folder);
			
			if !_file_cache.wwwroot_has_folder(new_folder_url) {
				PLogger.log_error("!_file_cache.wwwroot_has_folder(new_folder_url) ! '{0}'".format([ new_folder_url ]));
				request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_500_INTERNAL_SERVER_ERROR);
				return;
			}
			
			if !folder.empty() {
				String full_path = _file_cache.wwwroot_get_folder_abspath(new_folder_url);
				
				if full_path.empty() {
					PLogger.log_error("full_path.empty()!");
					request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_500_INTERNAL_SERVER_ERROR);
					return;
				}
				
				Directory d = Directory.new();
				d.remove(full_path);
			}
		} else if action == EditActions.DELETE {
			String file = request.get_post_parameter("file");
			String file_uri_path = target_folder_url.append_path(file);
			
			if !_file_cache.wwwroot_has_file(file_uri_path) {
				PLogger.log_error("!_file_cache.wwwroot_has_file(file_uri_path)");
				request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_500_INTERNAL_SERVER_ERROR);
				return;
			}

			if !file_uri_path.empty() {
				String full_path = _file_cache.wwwroot_get_file_abspath(file_uri_path);
				
				if full_path.empty() {
					PLogger.log_error("full_path.empty()!");
					request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_500_INTERNAL_SERVER_ERROR);
					return;
				}
				
				Directory d = Directory.new();
				d.remove(full_path);
			}
		}
	}
	
	String rp = request.get_current_path_segment();

	if (rp.empty()) {
		handle_request(request);
		return;
	}

	String file_name = request.get_path(true, false);
	#file_name = file_name.to_lower();
	
	String fabspath = _file_cache.wwwroot_get_file_abspath(file_name);

	if (!fabspath.empty()) {
		request.send_file(fabspath);
		
		return;
	}
	
	if (!try_route_request_to_children(request)) {
		handle_request(request);
	}
}

# This will only get called if we need a folder listing
void _handle_request(WebServerRequest request) {
	String target_folder_url = request.get_path(true, false);

	String target_folder_abspath = _file_cache.wwwroot_get_folder_abspath(target_folder_url);

	# Folder does not exists!
	if target_folder_abspath.empty() {
		request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_404_NOT_FOUND);
		return;
	}
	
	render_menu(request);
	
	if render_back_arrow {
		HTMLBuilder b = HTMLBuilder.new();
		
		b.div("row mb-4");
		b.div("col-2");
		b.cdiv();
			
		b.div("col-8 pt-2 pb-2 panel_content");
		
		b.h4();
		b.a(get_full_uri_parent()).f().w("<--- back").ca();
		b.ch4();
		
		b.cdiv();
		
		b.div("col-2");
		b.cdiv();
		b.cdiv();
		
		b.write_tag();
		
		request.body += b.result;
	}
	
	request.body += evaluate_dir(request, target_folder_abspath, target_folder_url == "/");
	request.compile_and_send_body();
}

String evaluate_dir(WebServerRequest request, String path, bool top_level = false) {
	Directory dir = Directory.new();
	dir.open(path);
	
	String serve_folder_abspath = _file_cache.get_wwwroot_abs();

	String dir_uri = "";

	if (!top_level) {
		dir_uri = path.substr(serve_folder_abspath.length(), path.length() - serve_folder_abspath.length());
	} else {
		dir_uri = "/";
	}
	
	PoolStringArray folders = PoolStringArray();
	PoolStringArray files = PoolStringArray();

	dir.list_dir_begin(true);

	String file = dir.get_next();

	while !file.empty() {
		String np = path.append_path(file);
		String nnp = np.substr(serve_folder_abspath.length(), np.length() - serve_folder_abspath.length());

		if (dir.current_is_dir()) {
			folders.push_back(nnp);
		} else {
			files.push_back(nnp);
		}

		file = dir.get_next();
	}
	
	dir.list_dir_end();

	folders.sort();
	files.sort();

	return render_dir_page(request, dir_uri, folders, files, top_level);
}

String render_dir_page(WebServerRequest request, String dir_uri, PoolStringArray folders, PoolStringArray files, bool top_level) {
	HTMLBuilder b = HTMLBuilder.new();

	String uri = get_full_uri(false);
		
	if uri == "/" {
		uri = "";
	}

	#b.div("file_list");
	{
		if (!top_level) {
			b.div("row").f().div("col-2").f().cdiv().div("col-8 pt-2 pb-2 panel_content");
			{
				b.a(uri + dir_uri.path_get_prev_dir()).f().w("..").ca();
			}
			b.cdiv().div("col-2").f().cdiv().cdiv();
		}

		for (int i = 0; i < folders.size(); ++i) {
			b.div("row").f().div("col-2").f().cdiv().div("col-8 pt-2 pb-2 panel_content");
			{
				b.form_post(uri + dir_uri, "form-inline");
				
				b.div("mr-5");
				b.a(uri + folders[i]).f().w("(Folder) ").w(folders[i].get_file()).ca();
				b.cdiv();
				
				{
					b.csrf_tokenr(request);
					b.input_hidden("action", str(EditActions.DELETE_FOLDER));
					b.input_hidden("folder", folders[i].get_file());
					b.input_submit("X");
				}
				
				b.cform();
			}
			b.cdiv().div("col-2").f().cdiv().cdiv();
		}
	

		for (int i = 0; i < files.size(); ++i) {
			b.div("row").f().div("col-2").f().cdiv().div("col-8 pt-2 pb-2 panel_content");
			
			{
				b.form_post(uri + dir_uri, "form-inline");
				
				b.div("mr-5");
				b.a(uri + files[i]).f().w("(File) ").w(files[i].get_file()).ca();
				b.cdiv();
				
				{
					b.csrf_tokenr(request);
					b.input_hidden("action", str(EditActions.DELETE));
					b.input_hidden("file", files[i].get_file());
					b.input_submit("X");
				}
				
				b.cform();
			}
			
			b.cdiv().div("col-2").f().cdiv().cdiv();
		}
		
		if folders.size() == 0 && files.size() == 0 {
			b.div("row").f().div("col-2").f().cdiv().div("col-8 pt-2 pb-2 panel_content");
			{
				b.w("Directory is empty.");
			}
			b.cdiv().div("col-2").f().cdiv().cdiv();
		}
	}
	#b.cdiv();
	
	b.div("row mt-4").f().div("col-2").f().cdiv().div("col-8 pt-2 pb-2 panel_content");
	b.w("Upload new file");
	b.cdiv().div("col-2").f().cdiv().cdiv();
	
	b.div("row").f().div("col-2").f().cdiv().div("col-8 pt-2 pb-2");
	b.form_post(uri + dir_uri).enctype_multipart_form_data();
	{
		b.csrf_tokenr(request);
		b.input_hidden("action", str(EditActions.UPLOAD));
		b.input_file("file");
		b.input_submit("Upload");
	}
	b.cform();
	b.cdiv().div("col-2").f().cdiv().cdiv();
	
	b.div("row mt-4").f().div("col-2").f().cdiv().div("col-8 pt-2 pb-2 panel_content");
	b.w("Create new folder");
	b.cdiv().div("col-2").f().cdiv().cdiv();
	
	b.div("row").f().div("col-2").f().cdiv().div("col-8 pt-2 pb-2");
	b.form_post(uri + dir_uri);
	{
		b.csrf_tokenr(request);
		b.input_hidden("action", str(EditActions.CREATE_FOLDER));
		b.input_text("folder");
		b.input_submit("Create");
	}
	b.cform();
	b.cdiv().div("col-2").f().cdiv().cdiv();
	
	b.write_tag();

	return b.result;
}
