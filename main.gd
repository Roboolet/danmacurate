extends Node
class_name Main

signal project_modified()
signal project_saved()

var layers:Array[Layer]
var selectedLayer:int
var projectFilePath:String
var projectName:String = "Untitled.danma"
var projectVersion:int = 0
var version:String

# keep track of all commands so they can be undo'd
var history:Array[Command]
var undoIndex:int

static var instance:Main

func _init() -> void:
	instance = self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projectFilePath = ProjectSettings.globalize_path("user://")	
	version = ProjectSettings.get_setting("application/config/version")
	reload_window_title()
	new_project()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("undo"):
		undo_command()
	else: if event.is_action_pressed("redo"):
		redo_command()
	else: if event.is_action_pressed("save"):
		save_project()

func reload_window_title():	
	get_tree().root.title = projectName + " - Danmacurate " + version

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
	if layers.size() == 0:
		layers.append(Layer.new())
	return layers[selectedLayer]

func select_layer(id:int) -> void:
	selectedLayer = id
	project_modified.emit()

func add_layer(layer:Layer) -> void:
	layers.append(layer)
	project_modified.emit()

func remove_layer(id:int) -> void:
	layers[id].is_marked_deleted = true
	project_modified.emit()

func save_project(path:String ="") -> void:
	# make directory if it does not exist
	if not DirAccess.dir_exists_absolute(projectFilePath):
		DirAccess.make_dir_absolute(projectFilePath);
	var finalPath
	if path == "":
		# automatic file path, mostly for Ctrl+S
		finalPath = projectFilePath + projectName
	else:
		finalPath = path
		projectName = path.get_file()
		projectFilePath = path.get_base_dir()+"/"
		reload_window_title()
	print("Saving project to " + finalPath + "...")
	
	# save the layers
	var layersToSave: Array[Dictionary]
	for l in layers:
		if !l.is_marked_deleted:
			layersToSave.append(l.property_data)
	var file = DanmaFile.new(layersToSave)
	projectVersion += 1
	file.fileVersion = projectVersion
	print("Saving .danma file with "+ str(layersToSave.size()) + " layers")
	
	# save the file
	var error = ResourceSaver.save(file, finalPath)
	print("RETURN CODE: " + str(error) + " " + error_string(error))
	project_saved.emit()

func open_project(path:String) ->  void:
	# find and get file
	if not DirAccess.dir_exists_absolute(projectFilePath):
		push_error("No project file found at " + path)
		return
	var danma:DanmaFile = ResourceLoader.load(path)
	projectVersion = danma.fileVersion
	
	# apply file
	new_project()
	layers.clear()
	for data in danma.layers:
		var newLayer:Layer = Layer.new()
		newLayer.property_data = data
		# solves weird conversion shenanigans
		if newLayer.property_data.has("layer_type"):
			newLayer.property_data["layer_type"] = int(newLayer.property_data["layer_type"])
		layers.append(newLayer)
	
	projectName = path.get_file()
	projectFilePath = path.get_base_dir() +"/"
	reload_window_title()	
	selectedLayer = 0
	project_modified.emit()

func new_project() -> void:
	# clear things
	layers.clear()
	history.clear()
	undoIndex = 0
	
	# initialize
	layers.append(Layer.new())
	projectName = "Untitled.danma"
	selectedLayer = 0
	
	project_modified.emit()
