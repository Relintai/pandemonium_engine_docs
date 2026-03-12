extends BrowsableFolderServeWebPage;

// This project sets up cors headers so it can host the javascript editor,
// or a gdnative or threads javascript exported app.

void _handle_request_main(WebServerRequest request) {
//	cross-origin-embedder-policy: require-corp
//	cross-origin-opener-policy: same-origin
//	cross-origin-resource-policy: same-origin
	request.custom_response_header_set("cross-origin-embedder-policy", "require-corp");
	request.custom_response_header_set("cross-origin-opener-policy", "same-origin");
	request.custom_response_header_set("cross-origin-resource-policy", "same-origin");
	
	
	._handle_request_main(request);
}
