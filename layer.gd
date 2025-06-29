extends RefCounted
class_name Layer
enum LayerType {SIMULATION, MANUAL, RELATIVE, VOLLEY}

var layer_type:LayerType
# used in-editor to make undoing deletion possible
var is_marked_deleted: bool
# the dictionary with all the actual data
var property_data:Dictionary

func set_value(variable:String, new_value):
	property_data[variable] = new_value
	print("Layer [number]: Set "+variable+ " to " +str(new_value))

func get_value(variable:String, default_value):
	match layer_type:
		LayerType.SIMULATION:
			return property_data.get(variable, default_value)
		
		LayerType.MANUAL:
			push_error("Manual layers not yet implemented")
			pass
		
		LayerType.RELATIVE:
			var self_prop = property_data.get(variable, default_value)
			
			var mother:Layer = property_data.get("mother")
			if mother and mother != self:
				var mom_prop = mother.property_data.get(variable, default_value)
				return safe_add(self_prop, mom_prop)
			else:
				return self_prop
		
		LayerType.VOLLEY:
			var mother:Layer = property_data.get("mother")
			var father:Layer = property_data.get("father")
			
			var mom_prop
			var dad_prop
			if mother and mother != self:
				mom_prop = mother.property_data.get(variable, default_value)
			else:
				mom_prop = default_value
			if father and father != self:
				dad_prop = father.property_data.get(variable, default_value)
			else:
				dad_prop = default_value
			
			return (mom_prop + dad_prop) * 0.5
	push_error("Unrecognized layer type: "+str(layer_type))

func get_value_raw(variable:String, default_value):
	return property_data.get(variable, default_value)

func safe_add(a, b):
	if typeof(a) in [TYPE_INT, TYPE_FLOAT] and typeof(b) in [TYPE_INT, TYPE_FLOAT]:
		return a + b
	elif typeof(a) == TYPE_STRING or typeof(b) == TYPE_STRING:
		return str(a) + str(b)
	else:
		push_warning("Cannot add values of types %s and %s" % [typeof(a), typeof(b)])
		return null
