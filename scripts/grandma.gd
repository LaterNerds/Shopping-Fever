extends CharacterBody2D

const speed = 300
const angle_threshold = 45  # Set an angle threshold for animation changes

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()

	# Calculate the angle between the direction vector and reference vectors
	var angle_forward = angle_between(dir, Vector2(0, -1))  # Angle between dir and forward vector
	var angle_right = angle_between(dir, Vector2(1, 0))    # Angle between dir and right vector
	
	# Determine which animation to play based on the angle
	if abs(angle_forward) < angle_threshold:
		sprite.play('walk_up')
	elif abs(angle_right) < angle_threshold:
		sprite.play('walk_right')
	else:
		sprite.play('walk_down')
	
	if GlobalVars.grandma_health <= 0:
		queue_free()

func makepath() -> void:
	nav_agent.target_position = GlobalVars.player_global_pos

func _on_timer_timeout():
	makepath()

# Function to calculate angle between two vectors
func angle_between(vec1: Vector2, vec2: Vector2) -> float:
	return rad_to_deg(atan2(vec2.y, vec2.x) - atan2(vec1.y, vec1.x))
