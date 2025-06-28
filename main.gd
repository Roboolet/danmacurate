extends Control
class_name Main

signal project_modified()

var layers:Array[Layer]
var selectedLayer:int
var projectFilePath:String
var projectName:String = "Untitled"
var version:String

# keep track of all commands so they can be undo'd
var history:Array[Command]
var undoIndex:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projectFilePath = ProjectSettings.globalize_path("user://")	
	version = ProjectSettings.get_setting("application/config/version")
	get_tree().root.title = projectName + " - Danmacurate " + version
	layers.append(Layer.new())
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("undo"):
		undo_command()
	else: if event.is_action_pressed("redo"):
		redo_command()

func new_command(cmd:Command):
	cmd.execute()
	# parallel universe check
	if(undoIndex != history.size()-1):
		history.resize(undoIndex+1)
	history.append(cmd)
	undoIndex = history.size()-1
	project_modified.emit()

func undo_command():
	if(undoIndex > 0):
		print("Undo: " + str(undoIndex) + " ---")
		history[undoIndex].undo()
		undoIndex -= 1
		project_modified.emit()

func redo_command():
	if(undoIndex < history.size()-1):
		undoIndex += 1
		print("Redo: " + str(undoIndex) + " ---")
		history[undoIndex].execute()
		project_modified.emit()

func get_current_layer() -> Layer:
	return layers[selectedLayer]

func select_layer(id:int) -> void:
	selectedLayer = id

func save_project(open_dialog: bool) -> void:
	# make directory if it does not exist
	if not DirAccess.dir_exists_absolute(projectFilePath):
		DirAccess.make_dir_absolute(projectFilePath);
	var finalPath = projectFilePath + projectName + ".danma"
	print("Saving project to " + finalPath + "...")
	
	var layersToSave: Array[Dictionary]
	for l in layers:
		if !l.is_marked_deleted:
			layersToSave.append(l.property_data)
	var file = DanmaFile.new(layersToSave)
	
	var error = ResourceSaver.save(file, finalPath)
	print("RETURN CODE: " + str(error) + " " + error_string(error))

func open_project() ->  void:
	pass
