class_name WeaponBase
extends EquipmentBase

@export var auto_aim := true

var can_attack := true
var _runtime_data: WeaponData

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
	_runtime_data = player.equipment_manager.get_final_weapon_data(data)

	#var attack = _runtime_data.attacks[0] # TODO: select attack based on pattern

	for attack in _runtime_data.attacks:
		attack.pattern.execute(self, player, attack)

	#_runtime_data.attack_pattern.execute(self, player, attack)


	player.update_target()
	player.on_attack.emit()

	can_attack = false
	await get_tree().create_timer(_runtime_data.cooldown).timeout

	can_attack = true


func get_runtime_data() -> WeaponData:
	return _runtime_data
