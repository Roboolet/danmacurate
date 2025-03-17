extends Sprite2D
class_name BulletSpawner

@export var bullet_prefab:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("layer_shoot"):
		pass
	pass


func spawn_bullet(props: Layer) -> void:
	var bullet:Node2D = bullet_prefab.instantiate()
	bullet.initialize(props)
	add_child(bullet)
	pass
