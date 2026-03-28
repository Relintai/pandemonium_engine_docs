extends UserLoginWebPage;

export(HTMLTemplate) HTMLTemplate login_template;

FormValidator _login_validator  = null;

#func _render_index(request: WebServerRequest) -> void:
#	request.set_post_parameter("username", request.get_post_parameter("username").to_upper())
#
#	._render_index(request)

void log_login_error(String uname_val, String error_str) {
	PLogger.log_important("{0}: User login error! name: \"{1}\", error str: \"{2}\"!".format([ Time.get_datetime_string_from_system(), uname_val, error_str ]));
}

void log_login_success(String uname_val) {
	PLogger.log_important("{0}: User login success! name: \"{1}\"!".format([ Time.get_datetime_string_from_system(), uname_val ]));
}

void _render_index(WebServerRequest request) {
	//request.set_post_parameter("username", request.get_post_parameter("username").to_upper())
	
	String error_str = String();
	String uname_val = String();
	String email_val = String();
	String pass_val = String();
	String pass_check_val = String();

	if (request.get_method() == HTTPServerEnums.HTTP_METHOD_POST) {
		PoolStringArray errors = _login_validator.validate(request);
		
		for (int i = 0; i < errors.size(); ++i) {
			error_str += errors[i] + "<br>";
		}

		uname_val = request.get_parameter("username");#.to_upper();
		pass_val = request.get_parameter("password");

		User user = UserDB.get_user_name(uname_val);

		if (user) {
			if (!user.check_password(pass_val)) {
				error_str += "Invalid username or password!";
			} else {
				HTTPSession session = request.get_or_create_session();

				session.add("user_id", user.get_user_id());

				request.get_server().get_session_manager().save_session(session);

				WebServerCookie c = WebServerCookie.new();
				c.set_data("session_id", session.get_session_id());
				c.set_path("/");
				c.http_only = true;
				c.secure = false;
				#c.use_expiry_date = false
				c.same_site = WebServerCookie.SAME_SITE_LAX;
				
				Dictionary exptime = Time.get_datetime_dict_from_system();
				exptime["year"] = exptime["year"] + 1;
				c.set_expiry_date_dt(exptime);
				
				request.response_add_cookie(c);
				
				log_login_success(uname_val);
				
				emit_signal("user_logged_in", request, user);

				Dictionary d = Dictionary();

				d["type"] = "render_login_success";
				d["user"] = user;

				_render_user_page(request, d);

				return;
			}
		} else {
			error_str += "Invalid username or password!";
		}
	}
	
	if !error_str.empty() {
		log_login_error(uname_val, error_str);
	}
	
	Dictionary d = Dictionary();

	d["type"] = "render_login_request_default";
	d["error_str"] = error_str;
	d["uname_val"] = uname_val;
	d["pass_val"] = pass_val;

	_render_user_page(request, d);
}

void _render_user_page(WebServerRequest request, Dictionary data) {
	String type = data["type"];

	if type == "render_login_success" {
		request.send_redirect(redirect_on_success_url);
		return;
	}
	
	request.body += login_template.render(request, data);
	request.compile_and_send_body();
}

void _ready() {
	_login_validator = FormValidator.new();

	_login_validator.new_field("username", "Username").need_to_exist().need_to_be_alpha_numeric().need_minimum_length(5).need_maximum_length(20);

	FormField pw = _login_validator.new_field("password", "Password");
	pw.need_to_exist();
	pw.need_to_have_lowercase_character().need_to_have_uppercase_character();
	pw.need_minimum_length(5);
}
