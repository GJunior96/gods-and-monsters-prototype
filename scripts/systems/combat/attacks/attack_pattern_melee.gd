class_name MeleeAttack
extends AttackPattern


func execute(equipment, player, data):
	#var slash = preload("res://effects/slash/arc_slash.tscn").instantiate()
	var attack_instance = data.attack_scene.instantiate()
	var forward = player.attack_direction.normalized()
	#var shape = player.get_node("CollisionShape2D").shape

	#var radius = 0.0
	player.get_parent().add_child(attack_instance)

	# if shape is RectangleShape2D:
	# 	radius = shape.size.x / 2
	# elif shape is CircleShape2D:
	# 	radius = shape.radius
	attack_instance.global_position = player.global_position
	attack_instance.setup(forward, data)
	attack_instance.hit_detected.connect(func(targets): _apply_damage(targets, data))


func _apply_damage(targets, data):
	for enemy in targets:
		enemy.take_damage(data.damage)
