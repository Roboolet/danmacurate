extends RefCounted
class_name Layer
enum LayerType {SIMULATION, MANUAL, RELATIVE, VOLLEY}

# used in-editor to make undoing deletion possible
var is_marked_deleted: bool
# the dictionary with all the actual data
var property_data:Dictionary

func set_value(variable:String, new_value):
	property_data[variable] = new_value
	print("Layer [number]: Set "+variable+ " to " +str(new_value))

func get_value(variable:String, default_value):
	return property_data.get_or_add(variable, default_value)
