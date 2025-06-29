extends FileDialog

func _ready() -> void:
	file_selected.connect(on_file_select)

func on_file_select(path:String) -> void:
	Main.instance.save_project(path)
