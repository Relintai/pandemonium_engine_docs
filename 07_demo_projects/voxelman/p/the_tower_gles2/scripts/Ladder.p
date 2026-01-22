extends Area;


void _ready() {
	connect("body_entered", this, "on_body_entered");
	connect("body_exited", this, "on_body_exited");
}

void on_body_entered(Variant body) {
	if body.has_method("ladder_area_entered") {
		body.ladder_area_entered(this);
	}
}

void on_body_exited(Variant body) {
	if body.has_method("ladder_area_exited") {
		body.ladder_area_exited(this);
	}
}
