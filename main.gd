extends Control
class_name Main

signal project_modified()

var layers:Array[Layer]
var selectedLayer:int
var projectFilePath:String

# keep track of all commands so they can be undo'd
var history:Array[Command]
var undo_index:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projectFilePath = ProjectSettings.globalize_path("user://")
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
	pass

func open_project() ->  void:
	pass
