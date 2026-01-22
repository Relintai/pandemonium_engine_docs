extends HTMLTemplate;

String _render(WebServerRequest request, Dictionary data) {
	data["csrf_token"] = request.get_csrf_token();
	
	String error_str = data["error_str"];
	
	if !error_str.empty() {
		data["error_str"] = get_and_render_template(@"Error", data);
	}
		
	if error_str.empty() && request.get_method() == HTTPServerEnums.HTTP_METHOD_POST {
		data["error_str"] = get_and_render_template(@"Success", data);
	}
	
	return get_and_render_template(@"Settings", data);
}
