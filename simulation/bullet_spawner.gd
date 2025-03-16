extends Sprite2D
class_name BulletSpawner

@export var bullet_prefab:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("layer_shoot"):
		var test_data = LayerProperties.new()
		test_data.offset.x = cos(Time.get_ticks_msec() * 0.01)*20
		test_data.offset.y = sin(Time.get_ticks_msec() * 0.01)*20
		test_data.velocity_initial = Vector2(1,0)
		spawn_bullet(test_data)
	pass


func spawn_bullet(props: LayerProperties) -> void:
	var bullet:Node2D = bullet_prefab.instantiate()
	bullet.initialize(props)
	add_child(bullet)
	pass
