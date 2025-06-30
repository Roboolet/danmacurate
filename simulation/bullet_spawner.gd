extends Sprite2D
class_name BulletSpawner

@export var bullet_prefab:PackedScene
@export var ghosting_alpha:float = 0.3
var main:Main
var bullet_timers:Array[float]
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
	
	for i in bullet_timers.size():
		bullet_timers[i] += delta
	
	for i in main.layers.size():
		var layer = main.layers[i]
		var bps = layer.get_value_raw("bullets_per_second", 1)
		bps = max(bps, 0.001)
		
		if bullet_timers[i] > 1/bps:
			bullet_timers[i] = 0
			# ghosted color
			var col = Color.from_rgba8(255,255,255,100)
			# selected color
			if i == main.selectedLayer:
				col = Color.AQUAMARINE
			
			if not layer.get_value_raw("layer_type", 0) == Layer.LayerType.VOLLEY:
				spawn_bullet(layer, col)
			else:
				for vol in layer.get_value_raw("volley_iterations", 1) as int:
					spawn_bullet(layer, col, 1+vol)
	
	#reset_timer += delta
	# TODO: change this so it uses the longest lifetime of all layers rather than
	# the current one
	#if reset_timer > main.get_current_layer().get_value("lifetime", 1):
	#	reset_sim()
	

func reset_sim() -> void:
	clear_bullets()
	bullet_timers.clear()
	for i in main.layers.size():
		bullet_timers.append(9999999)
	#reset_timer = 0

func clear_bullets() -> void:
	# assumes all children are bullets
	# this could never go wrong!
	for child in get_children():
		child.queue_free()

func spawn_bullet(props: Layer, color:Color, volley_iteration:int = 1) -> void:
	var bullet:Node2D = bullet_prefab.instantiate()
	bullet.initialize(props, volley_iteration)
	bullet.modulate = color
	add_child(bullet)
	pass
