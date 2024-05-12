extends StaticBody2D

func _on_area_2d_area_entered(area):
	# Check if label_instance is valid before calling _add_score function
	if area.get_parent().name == "player" && area.name != "Lysol":
		GlobalVars.score += 1000
		$"../../AudioStreamPlayer2D4".play()
		queue_free()
