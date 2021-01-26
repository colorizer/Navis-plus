extends Area

signal endreached(pc, tl)

var peoplecollected = 0
var timeleft = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Endpoint_body_entered(body):
	if body.name == "Player_Boat":
		$Timer.start()




func _on_Timer_timeout():
	emit_signal("endreached", peoplecollected, timeleft)
	get_parent().queue_free()
	get_tree().change_scene("res://assets/Endpoint/Success.tscn")
