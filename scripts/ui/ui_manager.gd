extends Node


@onready var ui_layer = $"../UI"

func _ready():
	EventBus.level_up_requested.connect(_on_level_up)


func _on_level_up(player):
	var ui = preload("res://scenes/ui/UpgradeUI.tscn").instantiate()
	ui_layer.add_child(ui)
	ui._show_upgrades(player)
