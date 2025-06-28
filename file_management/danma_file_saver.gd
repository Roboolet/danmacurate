extends ResourceFormatSaver
class_name DanmaSaver

func _get_recognized_extensions(res):
	if res is DanmaFile:
		return ["danma"]
	return []

func _recognize(res):
	return res is DanmaFile

func _save(resource: Resource, path: String, flags: int) -> Error:
	# Open file
	if not (resource is DanmaFile):
		return ERR_UNAVAILABLE

	var file = FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		return ERR_CANT_OPEN
	
	var danma = resource as DanmaFile
	# FILE CONTENTS !!!!!
	var layers_data ={}
	for i in danma.layers.size():
		var dict = danma.layers[i] as Dictionary
		var layer = {}
		for key in dict.keys():
			var value = dict[key]
			layer.set(key,value)
		layers_data.set(i, layer)
	
	var data = {
		"file_type": "DanmaFile",
		"file_version": danma.fileVersion,
		"release_version": danma.toolVersion,
		"layers": layers_data,
	}
	# Finish write
	var json_text = JSON.stringify(data, "\t", false)
	file.store_line(json_text)
	file.close()	
	return OK
