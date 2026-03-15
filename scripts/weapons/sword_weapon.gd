class_name Sword
extends WeaponBase

func _process(delta):
	var target = get_closest_enemy()
	
	if target:
		look_at(target.global_position)


func attack():
	var enemies = get_tree().get_nodes_in_group("enemies")

	for enemy in enemies:
		var dist = global_position.distance_to(enemy.global_position)

		if dist <= data.attack_radius:
			enemy.take_damage(data.damage)
