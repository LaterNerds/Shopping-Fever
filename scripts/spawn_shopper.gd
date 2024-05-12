extends Node2D

@onready var shopper = preload("res://scenes/shopper.tscn")
var new = false
var counter = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	instantiate()

func _process(delta):
	if new && counter < 10:
		counter += delta
	if new && counter >= 10:
		instantiate()
		new = false
		counter = 0

func instantiate():
	var shopper_instance = shopper.instantiate()
	get_node("../../").add_child.call_deferred(shopper_instance)
	shopper_instance.position = position
	shopper_instance.name = name

func create_new():
	new = true
