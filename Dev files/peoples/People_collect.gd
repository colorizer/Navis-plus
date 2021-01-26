extends Control

onready var counter = $Count

var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	counter.text = String(count)



func _on_people_peopleCollected():
	count = count + 1
	Global.people = count
	_ready()
