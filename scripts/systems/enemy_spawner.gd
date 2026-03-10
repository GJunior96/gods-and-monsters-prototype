extends Node2D


@export var enemy_scenes: Array[PackedScene]
@export var spawn_interval := 2.5
@export var spawn_distance := 400.0
@export var max_enemies := 15

var player: CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("player")
	_spawn_loop()

func _spawn_loop():
	while true:
		spawn_enemy()
		await get_tree().create_timer(spawn_interval).timeout


func spawn_enemy():
	var available = get_available_enemies()

	if available.is_empty():
		return

	var random_scene = available.pick_random()

	if get_tree().get_nodes_in_group("enemies").size() >= max_enemies:
		return


	if player == null or enemy_scenes == null:
		return

	var enemy = random_scene.instantiate()

	var difficulty = GameManager.get_difficulty_multiplier()
	enemy.setup(difficulty)
	enemy.name = "Enemy_%d" % randi()
	add_child(enemy)

	var angle = randf() * TAU
	var offset = Vector2(cos(angle), sin(angle)) * spawn_distance
	enemy.global_position = player.global_position + offset

	enemy.target = player	


func get_available_enemies():
	var available := []

	for scene in enemy_scenes:
		var enemy = scene.instantiate()

		if GameManager.time_survived >= enemy.min_spawn_time:
			available.append(scene)
			#GlobalLogger.log("ENEMY: %s SPAWN TIME: %s " % [ enemy.name, enemy.min_spawn_time ])
			
		enemy.queue_free()

	return available
