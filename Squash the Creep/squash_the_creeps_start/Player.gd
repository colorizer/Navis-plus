extends KinematicBody

const ARRIVE_THRESHOLD: = 100.0
# speed in m/s
export var max_speed = 500
#export var target_path: = NodePath()
#Down acceleration in m/s^2
export var fall_acceleration = 75

var _velocity = Vector2.ZERO
var _velocity3 = Vector3.ZERO

func _physics_process(_delta: float) -> void:
	var target_global_position: = Vector2.ZERO
	var direction: = Vector3.ZERO
	var global_pos = vec2_vec3($Pivot.get_translation(),2)
	if Input.is_mouse_button_pressed(1):
		target_global_position = get_viewport().get_mouse_position()
	else:
		return
	_velocity3 = vec3_vec2(Steering.follow(
		_velocity,
		global_pos,
		target_global_position,
		max_speed
	), 1, 0)
	
	direction = _velocity3.normalized()
	$Pivot.look_at(translation + direction, Vector3.UP)
	_velocity3 = move_and_slide(_velocity3, Vector3.UP)
#

func vec3_vec2(vec2, axis, value):
	var array = [vec2.x, vec2.y]
	array.insert(axis, value)
	return Vector3(array[0], array[1], array[2])

func vec2_vec3(vec3, axis):
	var array = [vec3.x, vec3.y, vec3.z]
	array.remove(axis)
	return Vector2(array[0], array[1])

#func _physics_process(delta):
#	#local variable to store input direction
#	var direction = Vector3.ZERO
#
#	#check the input and update the direction accordingly
#	if Input.is_action_pressed("move_right"):
#		direction.x += 1
#	if Input.is_action_pressed("move_left"):
#		direction.x -= 1
#	if Input.is_action_pressed("move_back"):
#		direction.z += 1
#	if Input.is_action_pressed("move_forward"):
#		direction.z -= 1
#
#	#...when 2 keys are pressed at a time
#	if direction != Vector3.ZERO:
#		direction = direction.normalized()
#		$Pivot.look_at(translation + direction, Vector3.UP)
#
#	#Ground velocity
#	velocity.x = direction.x * speed
#	velocity.z = direction.z * speed
#	#Vertical velocity
#	velocity.y -= fall_acceleration * delta
#	# Moving the character
#	velocity = move_and_slide(velocity, Vector3.UP)
	
