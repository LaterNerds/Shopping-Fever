extends Control

var box_node_path = NodePath(".")  # Set the path to your box node
var box_rect

func _ready():
	set_process_input(true)
	# Get the box node and its position/size
	var box_node = get_node(box_node_path)
	if box_node:
		box_rect = Rect2(box_node.position, box_node.size)
	else:
		print("Box node not found!")
func _input(event):
	# Check for mouse input events
	if event is InputEventMouseButton:
		# Check if the left mouse button is pressed for the first time and if it's inside the box
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if box_rect.has_point(get_global_mouse_position()):
				GlobalVars.player_health = 100
				get_tree().change_scene_to_file("res://scenes/game.tscn")
				
