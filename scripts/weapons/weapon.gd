extends Node2D

@export var projectile_scene: PackedScene
@export var fire_rate := 0.6
@export var range := 500.0

var can_fire := true

#func _process(delta):
#	if can_fire:
#		shoot()

func try_shoot():
	if not can_fire:
		return

	var target = get_closest_enemy()
	if target == null:
		return

	can_fire = false

	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)

	projectile.global_position = global_position
	projectile.direction = (target.global_position - global_position).normalized()

	await get_tree().create_timer(fire_rate).timeout
	can_fire = true

#func shoot():
#	var target = get_closest_enemy()
#	if target == null:
#		return
#
#	can_fire = false
#
#	var projectile = projectile_scene.instantiate()
#
#	print("Weapon:", global_position)
#	print("Target:", target.global_position)
#	print("Dir:", target.global_position - global_position)
#
#
#	projectile.global_position = global_position
#	projectile.direction = (target.global_position - global_position).normalized()
#	print(projectile.direction)
#	await get_tree().create_timer(fire_rate).timeout
#	can_fire = true


func get_closest_enemy():
	var enemies = get_tree().get_nodes_in_group("enemies")
	var closest = null
	var min_dist = range

	for enemy in enemies:
		print(enemy.name, enemy.global_position)
		var dist = global_position.distance_to(enemy.global_position)
		if dist < min_dist:
			min_dist = dist
			closest = enemy

	return closest
