extends Spatial


onready var camera = $CameraPivot/Camera
onready var cursor= $Cursor
onready var follower = $Mouse_path/Mouse_follow/Cursor2follow
onready var mousepath = $Mouse_path
onready var mousefollow = $Mouse_path/Mouse_follow

# Called when the node enters the scene tree for the first time.
func _ready():
#	mousefollow.rotation_mode = PathFollow.ROTATION_Y
	mousefollow.loop = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(delta):
	mouse_path()
	if !Input.is_action_pressed("Click"):
		followmouse(delta)


func mouse_path():
	var ray_length = 1000
	var dropPlane = Plane(Vector3.UP, 2.0)
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var cursor_pos = dropPlane.intersects_ray(from,to)
#	cursor_pos.y = 1.0
#	if Input.is_action_just_pressed("Click"):
#		mousepath.global_transform.origin = cursor_pos
	if Input.is_action_pressed("Click"):
		mousepath.curve.add_point(cursor_pos)
		print(mousepath.curve.get_point_count())
	cursor.global_transform.origin = cursor_pos

func followmouse(delta):
	mousefollow.set_offset(mousefollow.get_offset() + 10*delta)
	print(mousefollow.get_offset())
	pass
