extends VoxelWorldBlocky;

float time = 0;

void _process(float delta) {
	time += delta;
	
	if time > 3 {
		if get_parent().has_method("next_level") {
			get_parent().next_level();
		}
		
		set_process(false);
	}
}
