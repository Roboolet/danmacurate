extends Button

func _ready() -> void:
	pressed.connect(on_press)

func on_press():	
	var main = Main.get_instance(self)
	var cmd:Command = NewLayerCommand.new(main)
	main.new_command(cmd)
