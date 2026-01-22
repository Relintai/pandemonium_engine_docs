extends KinematicBody;

float camera_angle = 0;
float mouse_sensitivity = 0.3;
Vector2 camera_change;

Vector3 velocity;
Vector3 direction;

#flying
const float FLY_SPEED = 10.0;
const float FLY_ACCEL = 8.0;
bool flying = false;

#waling
float gravity = -9.8 * 4;
const float MAX_SPEED = 10.0;
const float MAX_RUNNING_SPEED = 16.0;
const float ACCEL = 14.0;
const float DEACCEL = 14.0;

#jumping
float jump_height = 12;
bool has_contact = false;
bool double_jumped = false;

float jump_height_modifier = 1;
float gravity_modifier = 1;
float walk_speed_modifier = 1;
float run_speed_modifier = 1;
float accel_modifier = 1;

#audio player
const float WALK_STEP_TIME = 0.5;
const float MIN_SOUND_TIME_LIMIT = 0.3;

AudioStreamPlayer3D foot_audio;
float step_timer = 0;
bool foot = false;
float last_sound_timer = 0;

void _ready() {
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	
	foot_audio = $foot as AudioStreamPlayer3D;
}

void _process(float delta) {
	if Input.is_action_just_pressed("ui_cancel") {
		if not $Menu.visible {
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
			$Menu.show();
		} else {
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
			$Menu.hide();
		}
	}
	
	if Input.is_action_just_pressed("restart") {
		if get_node("../../").has_method("reload") {
			get_node("../../").reload();
		}
	}
}

void _physics_process(float delta) {
	aim();
	
	last_sound_timer += delta;
	
	if flying {
		fly(delta);
	} else {
		walk(delta);
	}
}

void fly(float delta) {
	direction = Vector3();
	
	Basis aim = $Head/Camera.global_transform.basis;
	
	if Input.is_action_pressed("move_forward") {
		direction -= aim.z;
	}
	
	if Input.is_action_pressed("move_backward") {
		direction += aim.z;
	}
	
	if Input.is_action_pressed("move_left") {
		direction -= aim.x;
	}
	
	if Input.is_action_pressed("move_right") {
		direction += aim.x;
	}
	
	if  Input.is_action_pressed("move_jump") {
		direction.y += 1;
	}
	
	direction = direction.normalized();
	
	Vector3 target = direction * FLY_SPEED * run_speed_modifier;
	velocity = velocity.linear_interpolate(target, FLY_ACCEL * delta);
	
	move_and_slide(velocity);
}

void walk(float delta) {
	direction = Vector3();
	
	Basis aim = $Head/Camera.global_transform.basis;
	
	if Input.is_action_pressed("move_forward") {
		direction -= aim.z;
	}
	
	if Input.is_action_pressed("move_backward") {
		direction += aim.z;
	}
	
	if Input.is_action_pressed("move_left") {
		direction -= aim.x;
	}
	
	if Input.is_action_pressed("move_right") {
		direction += aim.x;
	}
		
	direction = direction.normalized();
	
	if is_on_floor() {
		has_contact = true;
	} else {
		if !$Contact.is_colliding() {
			has_contact = false;
		}
	}
	
	if has_contact and !is_on_floor() {
		move_and_collide(Vector3(0, -1, 0));
	}
	
	velocity.y += gravity * delta * gravity_modifier;
	
	Vector3 temp_velocity = velocity;
	temp_velocity.y = 0;
	
	float speed;
	float accel_multiplier = 1;
	if Input.is_action_pressed("move_sprint") {
		accel_multiplier = 1.2;
		speed = MAX_RUNNING_SPEED * run_speed_modifier;
	} else {
		speed = MAX_SPEED * walk_speed_modifier;
	}
	
	float accel;
	if direction.dot(temp_velocity) > 0 {
		accel = ACCEL * accel_multiplier;
	} else {
		accel = DEACCEL * accel_multiplier;
	}
	
	Vector3 target = direction * speed;
	temp_velocity = temp_velocity.linear_interpolate(target, ACCEL * delta);
	
	velocity.x = temp_velocity.x;
	velocity.z = temp_velocity.z;

	if not has_contact and not double_jumped and Input.is_action_just_pressed("move_jump") {
		double_jumped = true;
		velocity.y = jump_height * jump_height_modifier;
	}
	
	if has_contact and Input.is_action_just_pressed("move_jump") {
		velocity.y = jump_height * jump_height_modifier;
		has_contact = false;
		double_jumped = false;
	
		
		if not foot_audio.playing and last_sound_timer >= MIN_SOUND_TIME_LIMIT {
			foot_audio.play();
			last_sound_timer = 0;
		}
		
		step_timer = 0;
	}
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0), true);
	
	if not has_contact and is_on_floor() {
		if not foot_audio.playing and last_sound_timer >= MIN_SOUND_TIME_LIMIT {
			foot_audio.play();
			last_sound_timer = 0;
		}
		
		step_timer = 0;
	}
	
	Vector3 v = velocity;
	v.y = 0;
	if has_contact and v.length() > 1 {
		step_timer += delta;
		
		if step_timer >= WALK_STEP_TIME {
			step_timer = 0;

			if not foot_audio.playing and last_sound_timer >= MIN_SOUND_TIME_LIMIT {
				foot_audio.play();
				last_sound_timer = 0;
			}
		}
	}
}

void _unhandled_input(InputEvent event) {
	if event is InputEventMouseMotion {
		camera_change = event.relative;
	}
}

void aim() {
	if camera_change.length() > 0 {
		$Head.rotate_y(deg2rad(-camera_change.x * mouse_sensitivity));
			
		float change = -camera_change.y * mouse_sensitivity;
			
		if camera_angle + change > -90 and camera_angle + change < 90 {
			$Head/Camera.rotate_x(deg2rad(change));
			camera_angle += change;
		}
		
		camera_change = Vector2();
	}
}

void ladder_area_entered(Variant ladder) {
	flying = true;
}

void ladder_area_exited(Variant ladder) {
	flying = false;
}

bool is_player() {
	return true;
}
