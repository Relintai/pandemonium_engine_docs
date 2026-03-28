extends UserSettingsWebPage;

export(HTMLTemplate) HTMLTemplate template;

class SettingsRequestData {
		String error_str = "";
		String pass_val = "";
		String pass_check_val = "";
}

FormValidator _profile_validator = null;

void _render_index(WebServerRequest request) {
	User user = request.get_meta("user");

	if !user {
		PLogger.log_error("UserSettingsWebPage _render_index !user");
		return;
	}
	
	SettingsRequestData data = SettingsRequestData.new();

	if request.get_method() == HTTPServerEnums.HTTP_METHOD_POST {
		data.pass_val = request.get_parameter("password");
		data.pass_check_val = request.get_parameter("password_check");

		bool changed = false;

		PoolStringArray errors = _profile_validator.validate(request);

		for (int i = 0; i < errors.size(); ++i) {
			data.error_str += errors[i] + "<br>";
		}

		if (errors.size() == 0) {
			if (data.pass_val != "") {
				if (data.pass_val != data.pass_check_val) {
					data.error_str += "The passwords did not match!<br>";
				} else {
					user.create_password(data.pass_val);

					changed = true;
				}
			}
			
			if (changed) {
				user.save();
				emit_signal("user_settings_changed", request, user);
			}
		}
	}
	
	Dictionary d  = Dictionary();

	d["user"] = user;
	d["error_str"] = data.error_str;
	d["pass_val"] = data.pass_val;
	d["pass_check_val"] = data.pass_check_val;

	_render_user_page(request, d);
}

void _render_user_page(WebServerRequest request, Dictionary data) {
	#print(data)

	request.body += template.render(request, data);
	request.compile_and_send_body();
}

void _ready() {
	_profile_validator = FormValidator.new();

	FormField pw = _profile_validator.new_field("password", "Password");
	pw.ignore_if_not_exists();
	pw.need_to_have_lowercase_character().need_to_have_uppercase_character();
	pw.need_minimum_length(5);

	_profile_validator.new_field("password_check", "Password check").ignore_if_other_field_not_exists("password").need_to_match("password");
}
