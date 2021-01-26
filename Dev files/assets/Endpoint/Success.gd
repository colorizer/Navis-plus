extends Control

var people = 2.0
var timeleft = 0.0

func _ready():
	var success = $success
	var failure = $failure
	if Global.people < people or Global.timeleft == timeleft:
		failure.set_visible(true)
		success.set_visible(false)
	else:
		success.set_visible(true)
		failure.set_visible(false)
	pass

func _on_endscreen_tree_exiting():
	Global.people = 0
	Global.timeleft = 0
