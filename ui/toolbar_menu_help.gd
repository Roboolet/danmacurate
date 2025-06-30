extends ToolbarMenu

func on_select(id: int) -> void:
	match id:
		0: # documentation
			Main.instance.undo_command()
		1: # examples
			Main.instance.redo_command()
