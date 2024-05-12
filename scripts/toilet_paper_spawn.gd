extends Node

var tilemap # Reference to your TileMap node
var spawn_count = 0

func _ready():
	# Set up your tilemap reference
	tilemap = $"../ground"

	# Call a function to spawn your child nodes 10 times
	for i in range(20):
		spawn_child()

func spawn_child():
	var min_position = Vector2(-457, -1300)
	var max_position = Vector2(2492, 1244)
	var random_position = Vector2.ZERO

	var obstacle_collisions = true

	while obstacle_collisions:
		random_position = Vector2(randi_range(min_position.x, max_position.x), randi_range(min_position.y, max_position.y))
		obstacle_collisions = check_obstacle_collisions(random_position)

	var child = load("res://scenes/paper.tscn").instantiate()
	child.position = random_position
	add_child(child)

	spawn_count += 1
	print("Spawned child ", spawn_count, " at position: ", random_position)

func check_obstacle_collisions(position):
	# Assuming you have an area2D node named 'Obstacle' in the scene
	var collisions = get_tree().get_nodes_in_group("Obstacle")

	for obstacle in collisions:
		if obstacle.get_global_bounds().intersects(Rect2(position.x, position.y, 1, 1)):
			return true

	return false
