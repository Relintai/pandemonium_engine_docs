extends Node;

export(NodePath) NodePath color_picker_path;

Color get_color() {
	StyleBoxFlat style_box = get_node(^"PanelContainer").get_theme_stylebox("panel");
	return style_box.bg_color;
}

void set_color(Color color) {
	StyleBoxFlat style_box = get_node(^"PanelContainer").get_theme_stylebox("panel");
	style_box.bg_color = color;
	
	get_node(color_picker_path).color = color;
}
