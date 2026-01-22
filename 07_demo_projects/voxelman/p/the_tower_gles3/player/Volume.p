extends HSlider;

void _ready() {
	connect("value_changed", this, "on_value_changed");
}

void on_value_changed(float value) {
	AudioServer.set_bus_volume_db(0, value);
}
