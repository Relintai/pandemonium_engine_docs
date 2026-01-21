extends WebRoot;

MarkdownRenderer markdown_renderer = null;

void serve_md(WebServerRequest request) {
	String path = request.get_path_full();
	
	String fabs = www_root_file_cache.wwwroot_get_file_abspath(path);
	
	if fabs == "" {
		request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_404_NOT_FOUND);
		return;
	}
	
	File f = File.new();
	if f.open(fabs, File.READ) != OK {
		request.send_error(HTTPServerEnums.HTTP_STATUS_CODE_404_NOT_FOUND);
		return;
	}
	
	request.body += markdown_renderer.render(f.get_as_text());
	
	f.close();
	
	request.compile_and_send_body();
}

void _handle_request_main(WebServerRequest request) {
	if request.get_path_full().ends_with(".md") {
		serve_md(request);
		return;
	}

	._handle_request_main(request);
}

void _ready() {
	markdown_renderer = MarkdownRenderer.new();
}
