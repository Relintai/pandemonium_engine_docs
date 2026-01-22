extends HTMLTemplate;

String _render(WebServerRequest request, Dictionary data) {
	if data["type"] == "header" {
		return get_and_render_template(@"Header", data);
	} else if data["type"] == "footer" {
		return get_and_render_template(@"Footer", data);
	} else {
		User user = request.get_meta("user", null);
		data["user"] = user;
		
		if user {
			return get_and_render_template(@"MainMenuLoggedIn", data);
		} else {
			return get_and_render_template(@"MainMenu", data);
		}
	}
}
