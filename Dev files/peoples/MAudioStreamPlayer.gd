extends AudioStreamPlayer

func _on_people1_body_entered(body):
	if body.name == "Player_Boat":
		var peopleM = AudioStreamPlayer.new()
		self.add_child(peopleM)
		peopleM.stream = load("res://peoples/male-ty.wav")
		self.set_volume_db(8.0)
		peopleM.play()
	
#
	
