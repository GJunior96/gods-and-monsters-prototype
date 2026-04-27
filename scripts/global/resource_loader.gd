class_name ResourceLoaderUtil
extends Node

static func _load_resources_from_folder(path: String, type_check = null) -> Array:
	var result := []

	var dir = DirAccess.open(path)
	if dir == null:
		push_error("Folder not found: " + path)
		return result
	
	for file in dir .get_files():
		if file.ends_with(".tres"):
			var res = load(path + "/" + file)

			if type_check == null or res.TYPE == (type_check):
				result.append(res)

	for folder in dir.get_directories():
		result += _load_resources_from_folder(path + "/" + folder, type_check)

	return result
