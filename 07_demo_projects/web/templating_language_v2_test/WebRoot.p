extends WebRoot;

export(HTMLTemplate) HTMLTemplate template;

String header;
String footer;

void _ready() {
	header = template.render(null, |{ "type": "header" }|);
	footer = template.render(null, |{ "type": "footer" }|);
}

void _render_main_menu(WebServerRequest request) {
	request.head = header;
	request.body += template.render(request, |{ "type": "menu" }|);
	request.footer = footer;
}
