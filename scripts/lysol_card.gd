extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		GlobalVars.has_lysol = true
		queue_free()
		call_deferred("spawn_child")

func spawn_child():
	$"../../lysol_spawn".spawn_child()
