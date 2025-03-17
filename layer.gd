extends RefCounted
class_name Layer
enum LayerType {SIMULATION, MANUAL, RELATIVE, VOLLEY}

# used in-editor to make undoing deletion possible
var is_marked_deleted: bool
# version of this tool used to make the layer
var version: String
# the dictionary with all the actual data
var data:Dictionary

func set_value(variable:String, new_value):
	data[variable] = new_value

func get_value(variable:String, default_value):
	return data.get_or_add(variable, default_value)
