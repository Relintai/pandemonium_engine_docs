extends CenterContainer;

void _ready() {
	$Main/VBoxContainer/Resume.connect("pressed", this, "on_pressed");
}

void on_pressed() {
	hide();
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
}
