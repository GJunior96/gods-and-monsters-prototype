class_name MeleeAttack
extends AttackPattern

var _already_hit = {}

func execute(_equipment, player, attack: AttackData):
	_already_hit.clear()

	var attack_instance = attack.attack_scene.instantiate()
	var forward = player.attack_direction.normalized()

	player.get_parent().add_child(attack_instance)


	attack_instance.global_position = player.global_position
	attack_instance.setup(forward, attack)
	attack_instance.hit_detected.connect(_on_hit_detected.bind(attack))

func _apply_damage(targets, attack: AttackData):
	for enemy in targets:
		enemy.take_damage(attack.damage)


func _on_hit_detected(targets: Array, attack: AttackData) -> void:
	var valid_targets = []
	for target in targets:
		if _already_hit.has(target):
			continue
		
		_already_hit[target] = true
		valid_targets.append(target)

	if valid_targets.size() > 0:
		_apply_damage(valid_targets, attack)

