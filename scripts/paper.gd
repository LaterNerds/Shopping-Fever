extends StaticBody2D

signal add_score

var label_instance = null
var paper_instance = null

func _ready():
	# Get a reference to the existing instance of the Label script
	label_instance = get_node("../../gui/score")  # Adjust the path as per your scene structure
	paper_instance = get_node("../../toilet_paper_spawn")

func _on_area_2d_area_entered(area):
	# Check if label_instance is valid before calling _add_score function
	if area.get_parent().name == "player" && area.name != "Lysol":
		if label_instance:
			label_instance._add_score(1000)  # Call the _add_score function from Label script
			paper_instance.spawn_child()
		else:
			print("Label instance not found!")
		queue_free()
