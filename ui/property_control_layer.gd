extends Range
class_name PropertyControlLayer

@export var variable_name: String
@export var value_default: int

var main: Main
func _ready():
	main = get_tree().root.get_child(0)
	main.project_modified.connect(on_project_modified)
	connect("value_changed", _on_value_changed)

func on_project_modified():
	var val = main.get_current_layer().get_value_raw(variable_name, value_default)
	max_value = main.layers.size()-1
	set_value_no_signal(val)

func _on_value_changed(val: int) -> void:
	var layer: Layer = main.get_current_layer()
	var cmd: Command = SetPropertyCommand.new(layer, variable_name, val, value_default)
	main.new_command(cmd)
	print("Set %s to %f" % [variable_name, val])
