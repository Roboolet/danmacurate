extends Node2D
class_name Bullet

var props:LayerProperties
var is_initialized:bool

var velocity:Vector2
var velocity_polar:Vector2

func initialize(properties:LayerProperties):
	props = properties
	is_initialized = true
	
	# set initial values
	position.x = props.offset.x
	position.y = props.offset.y
	
	velocity = props.velocity_initial
	velocity_polar = props.velocity_initial_polar

func _process(delta: float) -> void:
	# apply velocity
	position.x += velocity.x
	position.y += velocity.y
