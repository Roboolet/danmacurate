extends ToolbarMenu

@export var open_dialog:FileDialog
@export var save_dialog:FileDialog

func _on_id_pressed(id: int) -> void:
	match id:
		0: # new
			if has_saved:
				main.new_project()
			else:
				#TODO: Add warning
				main.new_project()
		1: # open
			if has_saved:
				open_dialog.visible = true
			else:
				#TODO: Add warning
				open_dialog.visible = true
		2: # save
			save_dialog.visible = true
		3: # save as
			save_dialog.visible = true
		4: # export
			pass
