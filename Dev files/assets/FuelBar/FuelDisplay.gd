extends Control

# Add a variable "max_time" to each level
# Add a signal 

var bar_red = preload("res://assets/FuelBar/barHorizontal_red.png")
var bar_green = preload("res://assets/FuelBar/barHorizontal_green.png")
var bar_yellow = preload("res://assets/FuelBar/barHorizontal_yellow.png")
onready var timer = $fuel_time
onready var bar = $FuelBar2D
onready var level = get_parent()
onready var mousepath = get_parent().get_node("Mouse_path")

func _ready():
	print("Parent level: ", level.get("max_time"))
	if level and level.get("max_time"):
		bar.max_value = level.get("max_time")
		bar.show()
		print(bar.max_value, level.max_time)
		timer.set_wait_time(bar.max_value)
		mousepath.connect("boat_moves", self, "handle_boat_moves")
		mousepath.connect("boat_stops", self, "handle_boat_stops")

func _physics_process(_delta):
	print("Timer stopped: ", timer.is_stopped())
	print("time left: ", timer.get_time_left())
	update_bar(timer.time_left)

func handle_boat_moves():
	if timer.is_stopped() and Input.is_action_just_released("Click"):
		timer.start(bar.max_value)
	else:
		timer.set_paused(false)
		
func handle_boat_stops():
	if !timer.is_paused():
		timer.set_paused(true)

func update_bar(amount):
	bar.texture_progress = bar_green
	if amount < 0.75 * bar.max_value:
		bar.texture_progress = bar_yellow
	if amount < 0.45 * bar.max_value:
		bar.texture_progress = bar_red
	bar.value = amount
