extends Command
class_name NewLayerCommand

var main:Main
var layer_id:int

func _init(main:Main) -> void:
	self.main = main

func execute():
	main.add_layer(Layer.new())
	layer_id = main.layers.size()-1

func undo():
	main.remove_layer(layer_id)
