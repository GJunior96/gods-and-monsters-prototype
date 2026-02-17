extends CanvasLayer

@onready var time_label = $VBoxContainer/TimeLabel

func _ready():
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float):
#	if GameManager.is_game_over:
#		visible = true
#		time_label.text = "Tempo: %.2f" % GameManager.time_survived

func display():
	visible = true
	time_label.text = "Tempo: %.2f" % GameManager.time_survived


func _on_restart_pressed():
	GlobalLogger.log("BOTAO RESTART CLICADO")
	get_tree().paused = false
	get_tree().reload_current_scene()
