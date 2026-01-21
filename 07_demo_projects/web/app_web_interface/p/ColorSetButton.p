extends Button;

export(NodePath) NodePath target_node;

void _on_ColorSetButton_pressed() {
	Color color = get_parent().get_node("ColorPickerButton").color;
	
	get_node(target_node).set_color(color);
}
