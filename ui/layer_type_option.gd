extends OptionButton

@export var mother_prop:Control
@export var father_prop:Control
@export var volley_prop:Control
@export var sim_props:Control

var main:Main
func _ready() -> void:
	item_selected.connect(on_item_selected)
	main = Main.instance
	main.project_modified.connect(on_project_modified)
	apply_layer_type(0, true)

func on_item_selected(id:int):
	apply_layer_type(id, true)
	main.project_modified.emit()

func on_project_modified() -> void:
	apply_layer_type( main.get_current_layer().get_value_raw("layer_type", 0))

func apply_layer_type(type:int, emit:bool = false):
	var layer = main.get_current_layer()
	selected = type
	match type:
		0: # Simulation
			if emit:
				layer.set_value("layer_type", Layer.LayerType.SIMULATION)
			mother_prop.visible = false
			father_prop.visible = false
			volley_prop.visible = false
			sim_props.visible = true
		1: # Manual
			if emit:
				layer.set_value("layer_type", Layer.LayerType.MANUAL)
			mother_prop.visible = false
			father_prop.visible = false
			volley_prop.visible = false
			sim_props.visible = false
		2: # Relative
			if emit:
				layer.set_value("layer_type", Layer.LayerType.RELATIVE)			
				# prevent confusing behaviour
				layer.set_value("scale_x", 0)
				layer.set_value("scale_y", 0)
				layer.set_value("lifetime", 0)
				layer.set_value("bullets_per_second", 0)
			mother_prop.visible = true
			father_prop.visible = false
			volley_prop.visible = false
			sim_props.visible = true
			
		3: # Volley
			if emit:
				layer.set_value("layer_type", Layer.LayerType.VOLLEY)
			mother_prop.visible = true
			father_prop.visible = true
			volley_prop.visible = true
			sim_props.visible = false
