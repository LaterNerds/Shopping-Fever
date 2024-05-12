extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		$"../../AudioStreamPlayer2D3".play()
		GlobalVars.player_health += 25
		queue_free()
		$"../../vaccine_spawn".spawn_child()
