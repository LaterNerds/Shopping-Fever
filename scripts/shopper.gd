extends CharacterBody2D

# Properties
var move_speed = 100
var wander_interval = 2  # Time interval for changing wandering direction

var wander_timer = 7
var wander_direction = Vector2()

var animation_player
var collision_detected = false

func _ready():
	var spritesheet = randi_range(1, 4)
	$Sprite2D.texture = load("res://assets/sprites/MarketSet_Customer" + str(spritesheet) + ".png")
	
	# Start wandering immediately
	update_wander_direction()
	
	# Get reference to AnimationPlayer
	animation_player = $AnimationPlayer

func _process(delta):
	wander_timer -= delta
	
	if wander_timer <= 0:
		update_wander_direction()
		wander_timer = wander_interval
	
	velocity = move_speed * wander_direction
	move_and_slide()
	$Sprite2D.position = position

	# Play animation based on direction
	if velocity.length_squared() > 0:
		var angle = velocity.angle()
		if abs(angle) < deg_to_rad(45) or abs(angle) > deg_to_rad(135):
			if angle > 0:
				animation_player.play("walk_left")
			else:
				animation_player.play("walk_right")
		else:
			if angle > 0:
				animation_player.play("walk_up")
			else:
				animation_player.play("walk_down")
	else:
		animation_player.stop()

# Update wander direction
func update_wander_direction():
	var direction = Vector2(randi_range(-1, 1), randi_range(-1, 1))
	if abs(direction.x) > abs(direction.y):
		wander_direction.x = sign(direction.x)
		wander_direction.y = 0
	else:
		wander_direction.y = sign(direction.y)
		wander_direction.x = 0

	# Ensure only one direction is non-zero
	if wander_direction.x != 0 and wander_direction.y != 0:
		if randf() > 0.5:
			wander_direction.x = 0
		else:
			wander_direction.y = 0
	


func _on_area_2d_area_entered(area):
	if area.is_in_group("obstacle"):
		# Calculate a new direction away from the obstacle
		var obstacle_position = area.global_position
		wander_direction = (global_position - obstacle_position).normalized()
