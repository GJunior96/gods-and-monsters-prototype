class_name WeaponBase
extends EquipmentBase

@export var auto_aim := true

var can_attack := true

func _process(_delta) -> void:
	if player:
		global_position = player.global_position
		
	if not data:
		return

	if auto_aim:
		var dir = player.attack_direction
		if dir:
			look_at(dir)


func try_attack() -> void:
	if not can_attack:
		return
	var final_data = player.equipment_manager.get_final_weapon_data(data)

	var attack = final_data.attacks[0] # TODO: select attack based on pattern

	final_data.attack_pattern.execute(self, player, attack)


	player.update_target()
	player.on_attack.emit()

	can_attack = false
	await get_tree().create_timer(final_data.cooldown).timeout

	can_attack = true

