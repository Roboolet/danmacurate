extends Resource
class_name DanmaFile

# metadata about this project file
var tool_version: String
var file_version: int

# layer/property data
var layers: Array[Dictionary]

func _init(layers_to_save: Array[Dictionary]) -> void:
	tool_version = ProjectSettings.get_setting("application/config/version")
