extends Area;

void _ready() {
	connect("body_entered", this, "on_body_entered");
}

void on_body_entered(Variant body) {
	if body.has_method("is_player") {
		if body.is_player() {
			Node parent = get_parent();
			
			while parent != null {
				if parent.has_method("next_level") {
					parent.next_level();
					return;
				}
				
				parent = parent.get_parent();
			}
		}
	}
}
