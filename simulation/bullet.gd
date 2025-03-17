extends Node2D
class_name Bullet

var props:Layer
var is_initialized:bool

var velocity:Vector2
var velocity_polar:Vector2

func initialize(properties:Layer):
	props = properties
	is_initialized = true

	# set initial values

func _process(delta: float) -> void:
	# apply velocity
	position.x += velocity.x * delta
	position.y += velocity.y * delta
