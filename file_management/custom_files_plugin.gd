extends EditorPlugin

var saver := DanmaSaver.new()

func _enter_tree():
	ResourceSaver.add_resource_format_saver(saver)

func _exit_tree():
	ResourceSaver.remove_resource_format_saver(saver)
