extends WebNode;

export(HTMLTemplate) HTMLTemplate template;

void _handle_request(WebServerRequest request) {
	LinkButton lb = get_node(^"%LinkButton5");
	
	request.body += template.get_and_render_template(@"Test1", |{ "lb": lb }|);
	request.body += template.get_and_render_template(@"Test2", |{}|);
//	request.body += template.get_and_render_template(@"Test3", |{}|);
//	request.body += template.get_and_render_template(@"Test4", |{}|);
//	request.body += template.get_and_render_template(@"Test5", |{}|);
	#request.body += template.render(request, |{  }|);
	request.compile_and_send_body();
}

