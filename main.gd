extends Control
class_name Main

signal project_modified()

var layers:Array[Layer]
var selectedLayer:int
var projectFilePath:String
var project_name:String = "Untitled"
var version:String

# keep track of all commands so they can be undo'd
var history:Array[Command]
var undo_index:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projectFilePath = ProjectSettings.globalize_path("user://")	
	version = ProjectSettings.get_setting("application/config/version")
	get_tree().root.title = project_name + " - Danmacurate " + version
	layers.append(Layer.new())

func new_command(cmd:Command):
	cmd.execute()
	# TODO: erase future if change made after undo
	history.append(cmd)
	undo_index = history.size()
	project_modified.emit()

func undo_command():
	if(undo_index > 0):
		history[undo_index].undo()
		undo_index -= 1
		project_modified.emit()

func redo_command():
	if(undo_index < history.size()):
		history[undo_index].execute()
		undo_index += 1
		project_modified.emit()

func get_current_layer() -> Layer:
	return layers[selectedLayer]

func select_layer(id:int) -> void:
	selectedLayer = id

func save_project(open_dialog: bool) -> void:
	print("Saving project to " + projectFilePath + project_name + "...")
	
	var layers_to_save: Array[Dictionary]
	for l in layers:
		if !l.is_marked_deleted:
			layers_to_save.append(l.property_data)
	var file = DanmaFile.new(layers_to_save)
	
	var error = ResourceSaver.save(file, projectFilePath+project_name)
	print("RETURN CODE: " + str(error) + " / " + error_string(error))

func open_project() ->  void:
	pass
