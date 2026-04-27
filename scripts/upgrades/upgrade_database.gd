extends Node

var upgrades: Array = []
var _loaded := false
var upgrades_by_id: Dictionary = {}

func _ensure_loaded():
	if _loaded:
		return

	upgrades = ResourceLoaderUtil._load_resources_from_folder("res://data/upgrades", UpgradeData.TYPE)
	_loaded = true


func get_available(player, manager) -> Array:
	_ensure_loaded()

	var result := []

	for upgrade in upgrades:
		if upgrade.can_offer(player, manager):
			result.append(upgrade)

	return result


func get_by_id(id: String) -> UpgradeData:
	_ensure_loaded()
	return upgrades_by_id.get(id)
