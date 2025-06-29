extends ToolbarMenu

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
				main.open_project("/home/leavdc/.local/share/godot/app_userdata/Danmacurate/Untitled.danma")
			else:
				#TODO: Add warning
				main.open_project("/home/leavdc/.local/share/godot/app_userdata/Danmacurate/Untitled.danma")
		2: # save
			main.save_project(false)
		3: # save as
			main.save_project(true)
		4: # export
			pass
