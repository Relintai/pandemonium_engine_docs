extends HTMLTemplate;

String _render(WebServerRequest request, Dictionary data) {
	String error_str = data["error_str"];
	
	if (!error_str.empty()) {
		data["error_str"] = get_and_render_template(@"LoginErrorStrTemplate", data);
	}
	
	data["username_prev_value"] = data["uname_val"];
	
	return get_and_render_template(@"Login", data);
}
