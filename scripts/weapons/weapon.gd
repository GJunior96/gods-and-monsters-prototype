class_name Weapon
extends Node2D

@export var projectile_scene: PackedScene
@export var fire_rate := 0.6
@export var range := 500.0
@export var base_damage := 10
@export var speed := 450.0
var damage_multiplier := 1.0


var can_fire := true

func try_shoot():
	if not can_fire:
		return

	var target = get_closest_enemy()
	if target == null:
		return

	can_fire = false

	var projectile = projectile_scene.instantiate()
	projectile.damage = base_damage * damage_multiplier
	projectile.speed = speed
	get_tree().current_scene.add_child(projectile)

	projectile.global_position = global_position
	projectile.direction = (target.global_position - global_position).normalized()

	await get_tree().create_timer(fire_rate).timeout
	can_fire = true


func get_closest_enemy():
	var enemies = get_tree().get_nodes_in_group("enemies")
	var closest = null
	var min_dist = range

	for enemy in enemies:
		var dist = global_position.distance_to(enemy.global_position)
		if dist < min_dist:
			min_dist = dist
			closest = enemy

	return closest


func upgrade(stat: String, amount: float):
	match stat:
		"damage":
			base_damage += amount
		"speed":
			speed += amount
		"range":
			range += amount
		"fire_rate":
			fire_rate -= max(0.05, fire_rate - amount)
