extends PropertyControl

@export var value_default:float

func _ready():
	connect("value_changed", value_changed)
	super()

func on_project_modified():
	pass

func value_changed(value:float):
	send_new_value(value, value_default)
	print("Set " + str(variable_name) + " to " + str(value))
	pass
