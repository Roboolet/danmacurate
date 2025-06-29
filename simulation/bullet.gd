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
		
	var scale := Vector2(props.get_value("scale_x", 1), props.get_value("scale_y", 1))	
	
	# planar movement
	var sin = sin(timer * props.get_value("velocity_planar_sin_speed", 0)) 
	sin *= props.get_value("velocity_planar_sin", 0)
	var cos = cos(timer * props.get_value("velocity_planar_cos_speed", 0)) 
	cos *= props.get_value("velocity_planar_cos", 0)
	
	position.x += (velocity.x + cos) * scale.x * delta
	position.y += (velocity.y + sin) * scale.y * delta
	velocity += accel * scale * delta
	accel.x += props.get_value("velocity_planar_jerk_x", 0) * scale.x * delta
	accel.y += props.get_value("velocity_planar_jerk_y", 0) * scale.y * delta
