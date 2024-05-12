extends Area2D

@onready var active = $Active
@onready var spawn = preload("res://scripts/spawn.gd")

func _ready():
	active.start()

func _on_body_entered(body):
	if body.is_in_group("shopper"):
		body.get_node("../shoppers_spawn/" + body.name).create_new()
		body.queue_free()

func _on_active_timeout():
	queue_free()
