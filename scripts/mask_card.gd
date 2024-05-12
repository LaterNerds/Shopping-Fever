extends Area2D

func _on_area_entered(area):
	print("collided")
	if area.get_parent().is_in_group("player") && area.name != "Lysol":
		GlobalVars.mask_protection += 5
		queue_free()
		$"../../mask_spawn".spawn_child()
		$"../../AudioStreamPlayer2D2".play()
