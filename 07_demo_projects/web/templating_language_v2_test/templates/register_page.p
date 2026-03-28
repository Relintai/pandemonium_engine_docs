extends HTMLTemplate;

String _render(WebServerRequest request, Dictionary data) {
	String error_str = data["error_str"];
	
	if !error_str.empty() {
		data["error_str"] = get_and_render_template(@"Error", data);
	}
	
	#b.input_text("username", data["uname_val"], "", "form-control", "username_input");
	#b.input_text("email", data["email_val"], "", "form-control", "email_input");

	return get_and_render_template(@"Register", data);
}
