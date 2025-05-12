extends Node2D

func _process(_delta):
	# Keep redrawing on every frame.
	update()


func _draw():
	# Get the touch helper singleton.
	var touch_helper = get_node("/root/TouchHelper")
	# Draw every pointer as a circle.
	for ptr_index in touch_helper.state.keys():
		var pos = touch_helper.state[ptr_index]
		var color = _get_color_for_ptr_index(ptr_index)
		color.a = 0.75
		draw_circle(pos, 40.0, color)


# Just a way of getting different colors.
func _get_color_for_ptr_index(index):
	var x = (index % 7) + 1
	return Color(float(bool(x & 1)), float(bool(x & 2)), float(bool(x & 4)))
