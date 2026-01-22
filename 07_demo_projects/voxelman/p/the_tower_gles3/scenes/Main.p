extends Node;

export(Array, PackedScene) Array levels;

int current_level_index = 0;

Node level = null;

void _enter_tree() {
	level = levels[current_level_index].instance();
	add_child(level);
}

void next_level() {
	call_deferred("next");
}

void next() {
	level.queue_free();
	remove_child(level);
	current_level_index += 1;
	
	if current_level_index >= levels.size() {
		current_level_index = 0;
	}
	
	level = levels[current_level_index].instance();
	add_child(level);
}

void reload() {
	call_deferred("reload_deferred");
}

void reload_deferred() {
	level.queue_free();
	remove_child(level);
	level = levels[current_level_index].instance();
	add_child(level);
}
