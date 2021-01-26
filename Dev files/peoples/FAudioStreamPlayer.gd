extends AudioStreamPlayer

func _on_people2_body_entered(body):
	if body.name == "Player_Boat":
		var peopleF = AudioStreamPlayer.new()
		self.add_child(peopleF)
		peopleF.stream = load("res://peoples/female-ty.wav")
		self.set_volume_db(3.0)
		peopleF.play()
