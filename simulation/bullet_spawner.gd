extends Sprite2D
class_name BulletSpawner

@export var bullet_prefab:PackedScene
@export var bullets_per_second:float = 2
var main:Main
var bullet_timer:float
#var reset_timer:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main = get_tree().root.get_child(0)
	main.project_modified.connect(on_project_modified)

func on_project_modified() -> void:
	reset_sim()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("reset_simulation"):
		reset_sim()
	bullet_timer += delta
	if bullet_timer > 1/bullets_per_second:
		bullet_timer = 0
		spawn_bullet(main.get_current_layer())
	
	#reset_timer += delta
	# TODO: change this so it uses the longest lifetime of all layers rather than
	# the current one
	#if reset_timer > main.get_current_layer().get_value("lifetime", 1):
	#	reset_sim()
	

func reset_sim() -> void:
	clear_bullets()
	spawn_bullet(main.get_current_layer())
	#reset_timer = 0

func clear_bullets() -> void:
	# assumes all children are bullets
	# this could never go wrong!
	for child in get_children():
		child.queue_free()

func spawn_bullet(props: Layer) -> void:
	var bullet:Node2D = bullet_prefab.instantiate()
	bullet.initialize(props)
	add_child(bullet)
	pass
