class_name ProjectileAttack
extends AttackPattern

func execute(weapon, player, data):
	var projectile = data.projectile_scene.instantiate()

	projectile.global_position = weapon.global_position
	projectile.direction = player.get_aim_direction()

	weapon.get_tree().current_scene.add_child(projectile)
