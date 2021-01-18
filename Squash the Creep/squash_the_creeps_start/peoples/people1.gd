extends Area


func _ready():
	pass

func _physics_process(delta):
	rotate_y(deg2rad(0.025))  #remove this line to remove rotation
	
func _on_people1_body_entered(body):
	if body.name == "Cursor2follow": #we may change this cursor2follow name
		$Timer.start()
	
func _on_Timer_timeout():
	queue_free()
