extends ResourceFormatLoader
class_name DanmaLoader

func _get_recognized_extensions():
	return ["danma"]

func _handles_type(name:StringName) -> bool:
	if name == "DanmaFile":
		return true
	else:
		return false

func _get_resource_type(path: String) -> String:
	if path.get_extension().to_lower() == "danma":
		return "DanmaFile"
	return ""

func _load(path: String, original_path: String, use_sub_threads: bool, cache_mode: int) -> Variant:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Failed to open .danma file at %s" % path)
		return null
	
	var content := file.get_as_text()
	file.close()	
	
	var json = JSON.parse_string(content)	
	print("Loading project from "+path + " ...")
	
	var layers:Array[Dictionary]
	var json_keys:Array = json["layers"].keys()
	for key in json_keys:
		layers.append(json["layers"][key])
	print("Layers: "+ str(layers.size()))
	
	var danma:DanmaFile = DanmaFile.new(layers)
	danma.fileVersion = json["file_version"] as int
	print("File version: "+ str(danma.fileVersion))
	danma.toolVersion = json["release_version"]
	print("Tool version: "+ str(danma.toolVersion))
	return danma;
