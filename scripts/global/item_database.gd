extends Node

var items_by_id := {}

func _ready():
	_load_items_from_folder("res://data/equipment")


func _load_items_from_folder(path: String):
	var dir = DirAccess.open(path)

	for file in dir.get_files():
		if file.ends_with(".tres"):
			var item = load(path + "/" + file)
			items_by_id[item.id] = item

	for folder in dir.get_directories():
		_load_items_from_folder(path + "/" + folder)
		

func get_item(id: String) -> EquipmentData:
	return items_by_id.get(id)
