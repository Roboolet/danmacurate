extends Control

var layers:Array[LayerProperties]
var selectedLayer:int
var projectFilePath:String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projectFilePath = ProjectSettings.globalize_path("user://")

func select_layer(id:int) -> void:
	selectedLayer = id

func get_selected_layer() -> LayerProperties:
	return layers[selectedLayer]

func add_layer() -> void:
	select_layer(0)

func save_project(open_dialog: bool) -> void:
	pass

func open_project() ->  void:
	pass
