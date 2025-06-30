extends Node2D
class_name Bullet

var props:Layer
var is_initialized:bool
var vol_mul:float

var velocity:Vector2
var velocity_polar:Vector2
var accel:Vector2
var accel_polar:Vector2

var timer:float

func initialize(properties:Layer, volley_iteration:int = 1):
	props = properties
	if props == null:
		return
	is_initialized = true
	
	# get volley mult
	var vol_frac:float = 1 / props.get_value_raw("volley_iterations", 1)
	vol_mul = vol_frac * (volley_iteration as float)

	# set initial values
	position.x += props.get_value("velocity_planar_offset_x", 0, vol_mul)
	position.y += props.get_value("velocity_planar_offset_y", 0, vol_mul)
	velocity.x = props.get_value("velocity_planar_initial_x", 0, vol_mul)
	velocity.y = props.get_value("velocity_planar_initial_y", 0, vol_mul)
	accel.x = props.get_value("velocity_planar_accel_x", 0, vol_mul)
	accel.y = props.get_value("velocity_planar_accel_y", 0, vol_mul)
	
	var poloff = Vector2(props.get_value("velocity_polar_offset_x", 0, vol_mul), props.get_value("velocity_polar_offset_y", 0, vol_mul))
	position += get_cart(poloff)
	velocity_polar.x = props.get_value("velocity_polar_initial_x", 0, vol_mul)
	velocity_polar.y = props.get_value("velocity_polar_initial_y", 0, vol_mul)
	accel_polar.x = props.get_value("velocity_polar_accel_x", 0, vol_mul)
	accel_polar.y = props.get_value("velocity_polar_accel_y", 0, vol_mul)

func _process(delta: float) -> void:
	timer += delta
	if timer > props.get_value("lifetime", 1, vol_mul):
		queue_free()
		
	var scale := Vector2(props.get_value("scale_x", 1, vol_mul), props.get_value("scale_y", 1, vol_mul))	
	
	# planar movement
	var sin = sin(timer * props.get_value("velocity_planar_sin_speed", 0, vol_mul)) 
	sin *= props.get_value("velocity_planar_sin", 0, vol_mul)
	var cos = cos(timer * props.get_value("velocity_planar_cos_speed", 0, vol_mul)) 
	cos *= props.get_value("velocity_planar_cos", 0, vol_mul)
	
	position.x += (velocity.x + cos) * scale.x * delta
	position.y += (velocity.y + sin) * scale.y * delta
	velocity += accel * scale * delta
	accel.x += props.get_value("velocity_planar_jerk_x", 0, vol_mul) * scale.x * delta
	accel.y += props.get_value("velocity_planar_jerk_y", 0, vol_mul) * scale.y * delta
	
	# polar movement
	var sin_polar = sin(timer * props.get_value("velocity_polar_sin_speed", 0, vol_mul)) 
	sin_polar *= props.get_value("velocity_polar_sin", 0, vol_mul)
	var cos_polar = cos(timer * props.get_value("velocity_polar_cos_speed", 0, vol_mul)) 
	cos_polar *= props.get_value("velocity_polar_cos", 0, vol_mul)
	
	var velpol = Vector2((velocity_polar.x + cos_polar) * scale.x * delta, (velocity_polar.y + sin_polar + position.y) * scale.y * delta)
	position += get_cart(velpol)
	velocity_polar += get_cart(accel_polar * scale * delta)
	accel_polar.x += props.get_value("velocity_polar_jerk_x", 0, vol_mul) * scale.x * delta
	accel_polar.y += props.get_value("velocity_polar_jerk_y", 0, vol_mul) * scale.y * delta

# convert from polar to cartesian/planar
func get_cart(vec:Vector2) -> Vector2:
	return Vector2(vec.x * cos(vec.y), vec.x * sin(vec.y))
