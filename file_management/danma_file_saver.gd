extends ResourceFormatSaver
class_name DanmaSaver

func _get_recognized_extensions(res):
	if res is DanmaFile:
		return ["danma"]
	return []

func _recognize(res):
	return res is DanmaFile

func _save(resource: Resource, path: String, flags: int) -> Error:
	if not (resource is DanmaFile):
		return ERR_UNAVAILABLE

	var file = FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		return ERR_CANT_OPEN

	# FILE CONTENTS
	file.store_line("Hello world!")
	file.close()	
	return OK
