extends ToolbarMenu

@export var doc_window:Window
@export var examples_window:Window

func on_select(id: int) -> void:
	match id:
		0: # documentation
			doc_window.show()
		1: # examples
			examples_window.show()
