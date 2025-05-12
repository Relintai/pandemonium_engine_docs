extends KinematicBody2D

var direction = Vector2()
export(float) var speed = 1000.0

onready var root = get_tree().root

func _ready():
	set_as_toplevel(true)


func _physics_process(delta):
	if not root.get_visible_rect().has_point(position):
		queue_free()

	var motion = direction * speed * delta
	var collision_info = move_and_collide(motion)
	if collision_info:
		queue_free()


func _draw():
	draw_circle(Vector2(), $CollisionShape2D.shape.radius, Color.white)
