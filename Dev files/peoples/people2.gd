extends Area

func _ready():
	pass

func _physics_process(delta):
	rotate_y(deg2rad(0.25))
	
	


func _on_people2_body_entered(body):
	if body.name == "Player_Boat": 
		$Timer.start()


func _on_Timer_timeout():
	queue_free()
