extends PopupMenu
class_name ToolbarMenu

var main:Main
func _ready() -> void:
	# find main/root
	main = get_tree().root.get_child(0)
