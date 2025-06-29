extends PopupMenu
class_name ToolbarMenu

var main:Main
var has_saved:bool
var has_saved_recently:bool
func _ready() -> void:
	# find main/root
	main = get_tree().root.get_child(0)
	main.project_saved.connect(on_project_saved)
	main.project_modified.connect(on_project_modified)

func on_project_saved() -> void:
	has_saved_recently = true
	has_saved = true

func on_project_modified() -> void:
	has_saved_recently = false
