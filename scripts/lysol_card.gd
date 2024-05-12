extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		GlobalVars.has_lysol = true
		queue_free()
		$"../../lysol_spawn".spawn_child()
