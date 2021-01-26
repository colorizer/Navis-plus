extends Spatial

onready var level = get_parent()
onready var camera = level.get_node("CameraPivot/Camera")
onready var cursor= level.get_node("Cursor")
onready var follower = level.get_node("Mouse_path/Mouse_follow/Boat")
onready var mousepath = level.get_node("Mouse_path")
onready var mousefollow = level.get_node("Mouse_path/Mouse_follow")

signal boat_moves
signal boat_stops

var BOAT_SPEED = 15.0
var WIND_SPEED = 10.0
var SPEED = 15.0

var touch = InputEventScreenTouch.new()
# Called when the node enters the scene tree for the first time.
func _ready():
#	mousefollow.rotation_mode = PathFollow.ROTATION_XY
	mousefollow.loop = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(delta):
	mouse_path()
	if !(Input.is_action_pressed("Click") or touch.is_pressed()):
		followmouse(delta)

func mouse_path():
	var ray_length = 1000
	var dropPlane = Plane(Vector3.UP, 0.0)
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var cursor_pos = dropPlane.intersects_ray(from,to)
	cursor_pos.y = 1.0
#	if Input.is_action_just_pressed("Click"):
#		mousepath.global_transform.origin = cursor_pos
	if Input.is_action_pressed("Click") or touch.is_pressed():
		mousepath.curve.add_point(cursor_pos)
		print(mousepath.curve.get_point_count())
	cursor.global_transform.origin = cursor_pos

func followmouse(delta):
	print("Length difference: ", abs(mousepath.curve.get_baked_length() - mousefollow.get_offset()))
	if abs(mousepath.curve.get_baked_length() - mousefollow.get_offset()) < 0.001:
		emit_signal("boat_stops")
	else:
		emit_signal("boat_moves")
	mousefollow.set_offset(mousefollow.get_offset() + SPEED*delta)
#	print(mousefollow.get_offset())
	pass

func _on_Upwind_body_entered(body):
	if body.name == "Player_Boat":
		if SPEED != BOAT_SPEED:
			SPEED = BOAT_SPEED
		else:
			SPEED = BOAT_SPEED - WIND_SPEED


func _on_Downwind_body_entered(body):
	if body.name == "Player_Boat":
		if not SPEED == BOAT_SPEED:
			SPEED = BOAT_SPEED
		else:
			SPEED = BOAT_SPEED + WIND_SPEED
