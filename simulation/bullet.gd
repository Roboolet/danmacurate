extends Node2D
class_name Bullet

var props:Layer
var is_initialized:bool

var velocity:Vector2
var velocity_polar:Vector2
var accel:Vector2
var accel_polar:Vector2

var timer:float

func initialize(properties:Layer):
	props = properties
	if props == null:
		return
	is_initialized = true

	# set initial values
	velocity.x = props.get_value("velocity_planar_initial_x", 0)
	velocity.y = props.get_value("velocity_planar_initial_y", 0)
	accel.x = props.get_value("velocity_planar_accel_x", 0)
	accel.y = props.get_value("velocity_planar_accel_y", 0)

func _process(delta: float) -> void:
	timer += delta
	if timer > props.get_value("lifetime", 1):
		queue_free()
	
	# apply velocity
	position.x += velocity.x * delta
	position.y += velocity.y * delta
	velocity += accel * delta
	accel.x += props.get_value("velocity_planar_jerk_x", 0) * delta
	accel.y += props.get_value("velocity_planar_jerk_y", 0) * delta
