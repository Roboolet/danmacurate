extends EditorPlugin

var saver := DanmaSaver.new()
var loader := DanmaLoader.new()

func _enter_tree():
	ResourceSaver.add_resource_format_saver(saver)
	ResourceLoader.add_resource_format_loader(loader)

func _exit_tree():
	ResourceSaver.remove_resource_format_saver(saver)
	ResourceLoader.remove_resource_format_loader(loader)
