extends ItemList

var main:Main
func _ready() -> void:
	main = get_tree().root.get_child(0)
	main.project_modified.connect(on_project_modified)

func on_project_modified() -> void:
	clear()
	for i in main.layers.size():
		var layer:Layer = main.layers[i]
		if not layer.is_marked_deleted:
			add_item("Layer "+ str(i))
	select(main.selectedLayer)
