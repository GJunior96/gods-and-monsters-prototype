class_name MeleeAttack
extends AttackPattern


func execute(equipment, player, data):
	for enemy in EnemyManager.enemies:
		var dist = equipment.global_position.distance_to(enemy.global_position)
		
		if dist <= data.attack_radius:
			enemy.take_damage(data.damage)
