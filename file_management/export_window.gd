extends Window

func _ready() -> void:
	close_requested.connect(on_close_requested)

func on_close_requested():
	hide()
