extends CharacterBody2D

var is_lysol_active = false

@onready var has_lysol_label = $"../gui/has_lysol_label"

# Car properties
var speed = 0
var acceleration = 500
var max_speed = 400
var min_speed = -300
var rotation_speed = 1.5
var max_steering_angle = 40
var drift_factor = 1
var friction = 400
var reverse_friction = 100
var in_covid = false
var elapsed_time = 0

@onready var texture_rect = $"../Shader/TextureRect"
const LYSOL = preload("res://scenes/lysol.tscn")

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
	if GlobalVars.has_lysol:
		has_lysol_label.text = "Lysol: Yes"
	else:
		has_lysol_label.text = "Lysol: No"
	
	#drift stuff
	movement_stuff(delta)
	if GlobalVars.mask_protection == 0:
		if GlobalVars.in_covid == true:
			elapsed_time += delta
		if elapsed_time >= 0.8:
			GlobalVars.player_health -= 10
			elapsed_time = 0
		if (GlobalVars.player_health <= 0):
			print("died")
			queue_free()
			get_tree().change_scene_to_file("res://scenes/death.tscn")
	
	get_node("../gui/health").text = "Health: " + str(GlobalVars.player_health)
	#keypressses
	if Input.is_action_just_pressed("use"):
		print(GlobalVars.has_lysol)
		print(is_lysol_active)
		if not is_lysol_active and GlobalVars.has_lysol:
			var instance = LYSOL.instantiate()
			add_child(instance)
			is_lysol_active = true
			$"../AudioStreamPlayer2D".play()

	if GlobalVars.player_health >= 101:
		GlobalVars.player_health = 100
	
	texture_rect.material.set_shader_parameter("vignette_opacity", 5 - (GlobalVars.player_health / 20))

# on player area entered
func _on_area_2d_area_entered(area):
	#if covid kil
	if area.is_in_group("covid"):
		GlobalVars.in_covid = true

func _on_area_2d_area_exited(area):
	GlobalVars.in_covid = false
	elapsed_time = 0

func _on_child_exiting_tree(node):
	if node is Area2D:
		is_lysol_active = false
		GlobalVars.has_lysol = false
