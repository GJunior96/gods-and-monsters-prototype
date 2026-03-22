class_name WeaponBase
extends EquipmentBase

#@export var data: WeaponData
@export var auto_aim := true

var can_attack := true

func _process(delta) -> void:
	if player:
		global_position = player.global_position
		
	if not data:
		return

	if auto_aim:
		var target = get_closest_enemy()
		if target:
			look_at(target.global_position)


func try_attack() -> void:
	if not can_attack:
		return

	var final_data = data.duplicate()

	for modifier in data.modifiers:
		modifier.apply(final_data)

	final_data.attack_pattern.execute(self, player, final_data)

	player.on_attack.emit()

	can_attack = false
	await get_tree().create_timer(final_data.cooldown).timeout

	can_attack = true


func get_closest_enemy():
	if not data:
		return null

	var enemies = EnemyManager.enemies
	var closest = null
	var min_dist = data.range

	for enemy in enemies:
		var dist = global_position.distance_to(enemy.global_position)
		if dist < min_dist:
			min_dist = dist
			closest = enemy

	return closest
