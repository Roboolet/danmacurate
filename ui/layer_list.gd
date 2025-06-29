extends ItemList

var main:Main
func _ready() -> void:
	main = get_tree().root.get_child(0)
	main.project_modified.connect(on_project_modified)
	item_selected.connect(on_select)

func on_project_modified() -> void:
	clear()
	for i in main.layers.size():
		var layer:Layer = main.layers[i]
		if not layer.is_marked_deleted:
			var typename = Layer.LayerType.keys()[layer.get_value_raw("layer_type", 0)]
			add_item("Layer %s [%s]" % [i, typename])
	select(main.selectedLayer)

func on_select(id:int):
	main.select_layer(id)
