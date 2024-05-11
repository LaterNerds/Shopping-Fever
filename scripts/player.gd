extends CharacterBody2D

#player stuf
var health = 100

# Car properties
var speed = 0
var acceleration = 500
var max_speed = 400
var min_speed = -100
var rotation_speed = 1.5
var max_steering_angle = 40
var drift_factor = 1
var friction = 400
var reverse_friction = 100
var in_covid = false
var elapsed_time = 0

@onready var texture_rect = $"../Shader/TextureRect"

func movement_stuff(delta):
	var input_vector = Vector2()
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	
	# Steering
	var rotate_direction = input_vector.x
	var rotation_amount = rotate_direction * rotation_speed * delta
	rotation_amount = clamp(rotation_amount, -max_steering_angle, max_steering_angle)
	rotate(rotation_amount)
	
	# Acceleration and braking
	var forward_direction = input_vector.y
	if forward_direction > 0:
		speed = min(speed + acceleration * delta, max_speed)
	elif forward_direction < 0:
		speed = max(speed - acceleration * delta, min_speed)
	else:
		if speed > 0:
			speed = max(0, speed - friction * delta)
		elif speed < 0:
			speed = min(0, speed + reverse_friction * delta)
	
	# Drifting
	if forward_direction == 0:
		var drift_speed = speed * drift_factor
		var drift_velocity = Vector2(drift_speed, 0).rotated(rotation)
		velocity = drift_velocity
		move_and_slide()
	else:
		velocity = Vector2(speed, 0).rotated(rotation)
		move_and_slide()
		
	if rotation_degrees > 90 or rotation_degrees < 0:
		$Sprite2D.flip_v = true
	else:
		$Sprite2D.flip_v = false

# Process inputs and update car movement
func _process(delta):
	#drift stuff
	movement_stuff(delta)
	if in_covid == true:
		elapsed_time += delta
	if elapsed_time >= 0.8:
		health -= 10
		elapsed_time = 0
		get_node("../gui/health").text = "Health: " + str(health)
	if (health <= 0):
		print("died")
		queue_free()
	
	texture_rect.material.set_shader_parameter("vignette_opacity", 5 - (health / 20))

# on player area entered
func _on_area_2d_area_entered(area):
	#if covid kil
	if area.is_in_group("covid"):
		in_covid = true

func _on_area_2d_area_exited(area):
	in_covid = false
	elapsed_time = 0
