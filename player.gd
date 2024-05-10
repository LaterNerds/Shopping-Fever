extends CharacterBody2D

var wheel_base = 20
var steering_angle = 15
var engine_power = 900
var friction = -55
var drag = -0.06
var braking = -450
var max_speed_reverse = 250
var slip_speed = 400
var traction_fast = 2.5
var traction_slow = 10
var max_speed = 600  # Maximum speed limit for the car

var acceleration = Vector2.ZERO
var steer_direction

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction(delta)
	calculate_steering(delta)
	move_and_slide()  # Apply sliding

func apply_friction(delta):
	if acceleration == Vector2.ZERO and velocity.length() < 50:
		velocity = Vector2.ZERO
	var friction_force = -velocity.normalized() * friction * delta  # Note the negative sign
	var drag_force = -velocity * drag * delta  # Note the negative sign
	acceleration += drag_force + friction_force

func get_input():
	var turn = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")  # Use action strength for smoother steering
	steer_direction = turn * deg_to_rad(steering_angle)
	if Input.is_action_pressed("ui_up") and velocity.length() < max_speed:
		acceleration += transform.x.normalized() * engine_power
	if Input.is_action_pressed("ui_down"):
		acceleration += transform.x.normalized() * braking

func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base / 2.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	var new_heading = rear_wheel.direction_to(front_wheel)
	var traction
	if velocity.length() > slip_speed:
		traction = traction_fast
	else:
		traction = traction_slow

	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = lerp(velocity, new_heading * velocity.length(), traction * delta)
	else:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	rotation = new_heading.angle()  # Align car rotation with its direction
