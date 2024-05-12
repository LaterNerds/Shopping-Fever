extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player") && body.name != "Lysol":
		GlobalVars.has_lysol = true
		queue_free()
