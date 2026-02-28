extends CanvasLayer

@onready var time_label = $VBoxContainer/TimeLabel

signal restart_game

func _ready():
	visible = false
	GameManager.request_game_over_screen.connect(display)


func display(time_survived):
	visible = true
	time_label.text = "Tempo: %.2f" % time_survived


func _on_restart_pressed():
	restart_game.emit()
