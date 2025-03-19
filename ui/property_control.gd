extends Control
class_name PropertyControl

@export var variable_name:String

var main:Main
func _ready() -> void:
	# find main/root
	main = get_tree().root.get_child(0)
	main.project_modified.connect(on_project_modified)

func on_project_modified():
	pass

func send_new_value(value, value_default):
	var layer:Layer = main.get_current_layer()
	var cmd:Command = SetPropertyCommand.new(layer, variable_name, value, value_default)
	main.new_command(cmd)
