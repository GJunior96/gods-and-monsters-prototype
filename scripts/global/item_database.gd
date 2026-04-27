extends Node

var items_by_id := {}
var _loaded := false

func _ensure_loaded():
	if _loaded:
		return

	var items = ResourceLoaderUtil._load_resources_from_folder("res://data/equipment", EquipmentData.TYPE)

	for item in items:
		items_by_id[item.id] = item

	_loaded = true


func get_item(id: String) -> EquipmentData:
	_ensure_loaded()
	return items_by_id.get(id)
