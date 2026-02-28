extends Node

var time_survived := 0.0
var is_game_over := false

signal request_upgrade_screen
signal request_game_over_screen(time)

func _ready():
	var player = get_tree().get_first_node_in_group("player")
	var upgrade_ui = get_tree().get_first_node_in_group("upgrade_ui")
	var game_over_iu = get_tree().get_first_node_in_group("game_over_ui")

	player.leveled_up.connect(_on_player_leveled_up)
	player.game_over.connect(_on_game_over)
	upgrade_ui.upgrade_finished.connect(_on_upgrade_finished)
	game_over_iu.restart_game.connect(_on_restart_game)

func _process(delta):
	if is_game_over:
		return

	time_survived += delta


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


func _on_player_leveled_up(level):
	pause_game()
	request_upgrade_screen.emit()


func _on_upgrade_finished():
	resume_game()