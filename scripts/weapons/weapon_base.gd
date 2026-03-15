class_name WeaponBase
extends EquipmentBase

@export var data: WeaponData

var can_attack := true

func try_attack():
	if not can_attack:
		return

	attack()

	player.on_attack.emit()

	can_attack = false
	await get_tree().create_timer(data.cooldown).timeout

	can_attack = true


func attack():
	pass


func get_closest_enemy():
	var enemies = EnemyManager.enemies
	var closest = null
	var min_dist = data.range

	for enemy in enemies:
		var dist = global_position.distance_to(enemy.global_position)
		if dist < min_dist:
			min_dist = dist
			closest = enemy

	return closest
