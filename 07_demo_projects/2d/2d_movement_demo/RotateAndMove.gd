extends KinematicBody2D

export (int) var speed = 200
export (float) var rot_speed = 1.5

var velocity = Vector2()
var rot_dir = 0

func get_input():
	rot_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		rot_dir += 1
	if Input.is_action_pressed('left'):
		rot_dir -= 1
	if Input.is_action_pressed('down'):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed('up'):
		velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	get_input()
	rotation += rot_dir * rot_speed * delta
	move_and_slide(velocity)
