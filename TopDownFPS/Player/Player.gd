extends KinematicBody

export var speed = 300
export var friction = 0.875
export var gravity = 80
export var camera_rotation_speed = 250

var move_direction = Vector3()
var vel = Vector3()
var mouse_track = Path.new()

onready var camera = $CameraRig/Camera
onready var camera_rig = $CameraRig
onready var cursor= $Cursor


func _ready():
	camera_rig.set_as_toplevel(true)
	cursor.set_as_toplevel(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


func _physics_process(delta):
	camera_follows_player()
	rotate_camera(delta)
	
	mousetrack(look_at_cursor())
	run(delta)
#	print(mouse_track)
	
	vel *= friction
	vel.y -= gravity*delta
	vel = move_and_slide(vel, Vector3.UP, true, 3)


func camera_follows_player():
	var player_pos = global_transform.origin
	camera_rig.global_transform.origin = player_pos


func rotate_camera(delta):
	if Input.is_action_pressed("rotate_camera_cw"):
		camera_rig.rotate_y(deg2rad(-camera_rotation_speed * delta)) 
	if Input.is_action_pressed("rotate_camera_ccw"):
		camera_rig.rotate_y(deg2rad(camera_rotation_speed * delta)) 


func look_at_cursor() -> Vector3:
	# Create a horizontal plane, and find a point where the ray intersects with it
	var player_pos = global_transform.origin
	var dropPlane  = Plane(Vector3(0, 1, 0), player_pos.y)
	# Project a ray from camera, from where the mouse cursor is in 2D viewport
	var ray_length = 1000
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var cursor_pos = dropPlane.intersects_ray(from,to)
	
	# Set the position of cursor visualizer
	cursor.global_transform.origin = cursor_pos + Vector3(0,1,0)
	
	# Make player look at the cursor
	look_at(cursor_pos, Vector3.UP)
	return cursor_pos


func run(delta):
	move_direction = Vector3()
	var camera_basis = camera.get_global_transform().basis
	if Input.is_action_pressed("up"):
		move_direction -= camera_basis.z
	elif Input.is_action_pressed("down"):
		move_direction += camera_basis.z
	if Input.is_action_pressed("left"):
		move_direction -= camera_basis.x
	elif Input.is_action_pressed("right"):
		move_direction += camera_basis.x
	move_direction.y = 0
	move_direction = move_direction.normalized()
	
	vel += move_direction*speed*delta


func mousetrack(cursor_pos: Vector3):
	if Input.is_action_pressed("go_here"):
		print(cursor_pos)
		mouse_track.curve.add_point(cursor_pos)
		print(mouse_track.curve.get_point_count())
	else:
		pass
