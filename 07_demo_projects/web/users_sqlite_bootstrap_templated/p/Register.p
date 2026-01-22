extends UserRegisterWebPage;

export(HTMLTemplate) HTMLTemplate register_default;
export(HTMLTemplate) HTMLTemplate register_success;

FormValidator _registration_validator = null;

void log_registration_error(String uname_val, String email_val, String error_str) {
	PLogger.log_important("{0}: User registration error! name: \"{1}\", email: \"{2}\", error str: \"{3}\"!".format([ Time.get_datetime_string_from_system(), uname_val, email_val, error_str ]));
}

void log_registration_success(String uname_val, String email_val) {
	PLogger.log_important("{0}: User registration success! name: \"{1}\", email: \"{2}\"!".format([ Time.get_datetime_string_from_system(), uname_val, email_val ]));
}

void _render_index(WebServerRequest request) {
	String error_str = String();
	String uname_val = String();
	String email_val = String();
	String pass_val = String();
	String pass_check_val = String();

	if (request.get_method() == HTTPServerEnums.HTTP_METHOD_POST) {
		PoolStringArray errors = _registration_validator.validate(request);

		for (int i = 0; i < errors.size(); ++i) {
			error_str += errors[i] + "<br>";
		}

		uname_val = request.get_parameter("username");
		
		#uname_val = uname_val.to_upper()
		email_val = request.get_parameter("email");
		pass_val = request.get_parameter("password");
		pass_check_val = request.get_parameter("password_check");

		# todo username length etc check
		# todo pw length etc check
		
		if (UserDB.is_username_taken(uname_val)) {
			error_str += "Username already taken!<br>";
		}

		if (UserDB.is_email_taken(email_val)) {
			error_str += "Email already in use!<br>";
		}

		if (pass_val != pass_check_val) {
			error_str += "The passwords did not match!<br>";
		}

		if (error_str.empty()) {
			User user = null;
			user = UserDB.create_user();

			user.set_user_name(uname_val);
			user.set_email(email_val);

			user.create_password(pass_val);
			user.save();

			emit_signal("user_registered", request, user);

			Dictionary d = Dictionary();

			d["type"] = "render_register_success";
			d["user"] = user;
			
			log_registration_success(uname_val, email_val);
			
			_render_user_page(request, d);

			return;
		} else {
			log_registration_error(uname_val, email_val, error_str);
		}
	}
	
	Dictionary d = Dictionary();

	d["type"] = "render_register_request_default";
	d["error_str"] = error_str;
	d["uname_val"] = uname_val;
	d["email_val"] = email_val;
	d["pass_val"] = pass_val;
	d["pass_check_val"] = pass_check_val;

	_render_user_page(request, d);
}

void _render_user_page(WebServerRequest request, Dictionary data) {
	if data["type"] == "render_register_success" {
		render_register_success(request, data);
		return;
	}
	
	render_register_default(request, data);
}

void render_register_success(WebServerRequest request, Dictionary data) {
	data["redirect_on_success_url"] = redirect_on_success_url;
	request.body += register_success.render(request, data);
	request.compile_and_send_body();
}

void render_register_default(WebServerRequest request, Dictionary data) {
	request.body += register_default.render(request, data);
	request.compile_and_send_body();
}


void _on_Register_user_registered(WebServerRequest request, User user) {
	user.read_lock();
	int uid  = user.user_id;
	user.read_unlock();
	
	user.write_lock();
	user.rank = 1;
	user.write_unlock();
	user.save();
	
#	if uid == 1:
#		user.write_lock()
#		user.rank = 3
#		user.write_unlock()
#		user.save()
#	else:
#		var ulevel : int = ProjectSettings.get("app/registration_start_user_level")
#		user.write_lock()
#		user.rank = ulevel
#		user.write_unlock()
#		user.save()
}

void _ready() {
	_registration_validator = FormValidator.new();
	
	_registration_validator.new_field("username", "Username").need_to_exist().need_to_be_alpha_numeric().need_minimum_length(5).need_maximum_length(20);
	_registration_validator.new_field("email", "Email").need_to_exist().need_to_be_email();

	FormField pw = _registration_validator.new_field("password", "Password");
	pw.need_to_exist();
	pw.need_to_have_lowercase_character().need_to_have_uppercase_character();
	pw.need_minimum_length(5);

	_registration_validator.new_field("password_check", "Password check").need_to_match("password");

	_registration_validator.new_field("email", "Email").need_to_exist().need_to_be_email();
}
