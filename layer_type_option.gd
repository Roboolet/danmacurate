extends OptionButton

@export var mother_prop:Control
@export var father_prop:Control
@export var sim_props:Control

func _ready() -> void:
	item_selected.connect(on_item_selected)
	apply_layer_type(0)

func on_item_selected(id:int):
	apply_layer_type(id)
	

func apply_layer_type(type:int):
	var layer = Main.get_instance(self).get_current_layer()
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
