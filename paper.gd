extends StaticBody2D

func _on_area_2d_area_entered(area):
	queue_free()
	get_node("../score").add_score(10000)
