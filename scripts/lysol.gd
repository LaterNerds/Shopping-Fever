extends Area2D

@onready var active = $Active
@onready var immune_timer = $Immune

var grandma_dying = false
var immune = false
var grandma

func _ready():
	active.start()

func _on_body_entered(body):
	if body.is_in_group("shopper"):
		body.get_node("../shoppers_spawn/" + body.name).create_new()
		body.queue_free()
	elif body.is_in_group("grandma"):
		grandma = body
		grandma_dying = true

func _on_body_exited(body):
	if body.is_in_group("grandma"):
		grandma_dying = false

func _process(delta):
	if grandma_dying and not immune:
		grandma.health -= 25
		immune = true
		immune_timer.start()
		

func _on_active_timeout():
	queue_free()

func _on_immune_timeout():
	immune = false
