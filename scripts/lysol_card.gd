extends Area2D

const PLAYER = preload("res://scenes/player.tscn")

func _on_body_entered(body):
	if body.has_method("set_meta"):
		print("pickup")
		body.set_meta("has_lysol", true)
		queue_free()
