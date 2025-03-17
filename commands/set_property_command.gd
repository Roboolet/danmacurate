extends Command
class_name SetPropertyCommand

var layer:Layer
var variable_name
var value_new
var value_old

func _init(layer:Layer, variable_name:String, value_new, value_default) -> void:
	self.value_new = value_new
	self.layer = layer
	self.variable_name = variable_name
	self.value_old = layer.get_value(variable_name, value_default)

func execute():
	layer.set_value(variable_name, value_new)

func undo():
	layer.set_value(variable_name, value_old)
