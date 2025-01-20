extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var hori:float = Input.get_axis("player_move_left","player_move_right")
	var veri:float = Input.get_axis("player_move_up", "player_move_down")
	
	translate(Vector2(hori, veri))
	pass
