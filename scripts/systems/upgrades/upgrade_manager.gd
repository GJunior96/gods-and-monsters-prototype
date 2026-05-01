class_name UpgradeManager
extends Node

var player
var upgrades := {} # id -> stacks
var global_modifiers: Array[Modifier] = []


func setup(p):
	player = p


func apply_upgrade(upgrade: UpgradeData):
	var current = upgrades.get(upgrade.id, 0)
	upgrades[upgrade.id] = current + 1

	rebuild()


func rebuild():
	# Clear all modifiers
	global_modifiers.clear()

	# reset base stats
	reset_player_stats()

	# Reapply all upgrades
	for id in upgrades.keys():
		var upgrade = UpgradeDatabase.get_by_id(id)
		if upgrade:
			upgrade.apply(player, self)


func reset_player_stats():
	player.speed = player.base_speed
	player.max_life = player.base_max_life


func get_stack(id: String) -> int:
	return upgrades.get(id, 0)


func add_modifier(modifier: Modifier) -> void:
	global_modifiers.append(modifier)


func get_modifiers() -> Array:
	return global_modifiers
