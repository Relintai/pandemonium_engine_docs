extends WebRoot;

export(String, MULTILINE) String menu_text;

void _render_main_menu(WebServerRequest request) {
	request.body += menu_text;
}
