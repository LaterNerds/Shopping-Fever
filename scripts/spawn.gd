extends Node2D

@onready var shopper = preload("res://scenes/shopper.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var shopper_instance = shopper.instantiate()
	get_node("../../").add_child.call_deferred(shopper_instance)
	shopper_instance.position = position
