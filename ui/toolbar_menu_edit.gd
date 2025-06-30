extends ToolbarMenu

func on_select(id: int) -> void:
	match id:
		0: # undo
			Main.instance.undo_command()
		1: # redo
			Main.instance.redo_command()
