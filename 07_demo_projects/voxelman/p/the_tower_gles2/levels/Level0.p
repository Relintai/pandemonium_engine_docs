extends VoxelWorldBlocky;


void _unhandled_key_input(InputEventKey event) {
	if event.scancode == KEY_ENTER {
		get_parent().next_level();
	}
}
