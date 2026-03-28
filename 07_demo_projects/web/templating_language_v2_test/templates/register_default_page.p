extends HTMLTemplate;

String _render(WebServerRequest request, Dictionary data) {
	return get_and_render_template(@"RegisterSuccess", data);
}
