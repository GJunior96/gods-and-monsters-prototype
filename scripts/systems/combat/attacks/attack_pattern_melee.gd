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
	attack_instance.hit_detected.connect(_on_hit_detected.bind(attack, player))

func _apply_damage(targets, attack: AttackData, player):
	for enemy in targets:

		var dir = (enemy.global_position - player.global_position).normalized()
		var context = {
			"damage": attack.damage,
			"knockback": attack.knockback_force,
			"source": player,
			"direction": dir
		}

		attack.hit_policy.apply(enemy, context)


func _on_hit_detected(targets: Array, attack: AttackData, player) -> void:
	var valid_targets = []
	for target in targets:
		if _already_hit.has(target):
			continue
		
		_already_hit[target] = true
		valid_targets.append(target)

	if valid_targets.size() > 0:
		_apply_damage(valid_targets, attack, player)
