extends Area2D

func _on_area_entered(area):
	print("collided")
	if area.get_parent().is_in_group("player") && area.name != "Lysol":
		GlobalVars.mask_protection += 5
		queue_free()
