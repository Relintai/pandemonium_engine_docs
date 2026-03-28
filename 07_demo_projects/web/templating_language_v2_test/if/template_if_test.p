extends WebNode;

export(HTMLTemplate) HTMLTemplate template;

void _handle_request(WebServerRequest request) {
	Dictionary d = |{ "var": 12 }|;
	request.body += template.get_and_render_template(@"Test1", d);
	request.body += template.get_and_render_template(@"Test2", d);
	request.body += template.get_and_render_template(@"Test3", d);
	request.body += template.get_and_render_template(@"Test4", d);
	
	request.body += template.get_and_render_template(@"Test5", |{ "sv": 1 }|);
	request.body += template.get_and_render_template(@"Test5", |{ "sv": 2 }|);
	request.body += template.get_and_render_template(@"Test5", |{ "sv": 3 }|);
	request.body += template.get_and_render_template(@"Test5", |{ "sv": 4 }|);
	
	#request.body += template.render(request, |{  }|);
	request.compile_and_send_body();
}

