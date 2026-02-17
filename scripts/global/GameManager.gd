extends Node


var time_survived := 0.0
var is_game_over := false

func _process(delta):
	if is_game_over:
		return

	time_survived += delta


func game_over():
	is_game_over = true
	get_tree().paused = true
	GlobalLogger.log("Game Over! Tempo sobrevivido: %s" % time_survived)

	var ui = get_tree().get_first_node_in_group("game_over_ui")
	if ui:
		ui.display()
