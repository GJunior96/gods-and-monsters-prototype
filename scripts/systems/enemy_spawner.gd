extends Node2D


@export var enemy_scene: PackedScene
@export var spawn_interval := 1.5
@export var spawn_distance := 400.0

var player: CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("player")
	_spawn_loop()

func _spawn_loop():
	while true:
		spawn_enemy()
		await get_tree().create_timer(spawn_interval).timeout


func spawn_enemy():
	if player == null or enemy_scene == null:
		return

	var enemy = enemy_scene.instantiate()
	get_parent().add_child(enemy)

	var angle = randf() * TAU
	var offset = Vector2(cos(angle), sin(angle)) * spawn_distance
	enemy.global_position = player.global_position + offset

	enemy.target = player	
