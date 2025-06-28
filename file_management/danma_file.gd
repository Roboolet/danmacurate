extends Resource
class_name DanmaFile

# metadata about this project file
var toolVersion: String
var fileVersion: int

# layer/property data
var layers: Array[Dictionary]

func _init(layers_to_save: Array[Dictionary]) -> void:
	toolVersion = ProjectSettings.get_setting("application/config/version")
