extends OptionButton

@export var mother_prop:Control
@export var father_prop:Control
@export var sim_props:Control

var main:Main
func _ready() -> void:
	item_selected.connect(on_item_selected)
	main = Main.get_instance(self)
	main.project_modified.connect(on_project_modified)
	apply_layer_type(0)

func on_item_selected(id:int):
	apply_layer_type(id)
	main.project_modified.emit()

func on_project_modified() -> void:
	apply_layer_type(main.get_current_layer().layer_type)

func apply_layer_type(type:int):
	var layer = main.get_current_layer()
	selected = type
	match type:
		0: # Simulation
			layer.layer_type = Layer.LayerType.SIMULATION
			mother_prop.visible = false
			father_prop.visible = false
			sim_props.visible = true
		1: # Manual
			layer.layer_type = Layer.LayerType.MANUAL
			mother_prop.visible = false
			father_prop.visible = false
			sim_props.visible = false
		2: # Relative
			layer.layer_type = Layer.LayerType.RELATIVE
			mother_prop.visible = true
			father_prop.visible = false
			sim_props.visible = true
		3: # Volley
			layer.layer_type = Layer.LayerType.VOLLEY
			mother_prop.visible = true
			father_prop.visible = true
			sim_props.visible = false
	pass
