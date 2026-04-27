extends Node

var time_survived := 0.0
var is_game_over := false

signal request_game_over_screen(time)

func _ready():
	var player = get_tree().get_first_node_in_group("player")
	var game_over_iu = get_tree().get_first_node_in_group("game_over_ui")

	player.game_over.connect(_on_game_over)
	game_over_iu.restart_game.connect(_on_restart_game)


func _process(delta):
	if is_game_over:
		return

	time_survived += delta


func get_difficulty_multiplier() -> float:
	var minutes = time_survived / 60.0
	return 1.0 + (minutes * 0.3)


func _on_game_over():
	is_game_over = true
	get_tree().paused = true
	GlobalLogger.log("Game Over! Tempo sobrevivido: %s" % time_survived)

	request_game_over_screen.emit(time_survived)


func pause_game():
	get_tree().paused = true


func resume_game():
	get_tree().paused = false


func _on_restart_game():
	resume_game()
	get_tree().reload_current_scene()
