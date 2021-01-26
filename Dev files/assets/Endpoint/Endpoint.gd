extends Area

signal endreached

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Endpoint_body_entered(body):
	if body.name == "Player_Boat":
		$Timer.start()




func _on_Timer_timeout():
	emit_signal("endreached")
	get_parent().queue_free()
	get_tree().change_scene("res://levelselect.tscn")
