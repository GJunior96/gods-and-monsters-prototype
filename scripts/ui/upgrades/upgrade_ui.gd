extends Control

@onready var buttons = [
	$CenterContainer/Panel/VBoxContainer/Option1,
	$CenterContainer/Panel/VBoxContainer/Option2,
	$CenterContainer/Panel/VBoxContainer/Option3
]

var current_upgrades := []
var player

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS


func hide_upgrade():
	visible = false


func _show_upgrades(p):
	player = p
	current_upgrades = UpgradeRoll.roll_upgrades(player, buttons.size())

	for i in range(buttons.size()):
		if i < current_upgrades.size():
			var up = current_upgrades[i]
			buttons[i].visible = true
			buttons[i].text = _format_upgrade(up)
			buttons[i].pressed.connect(_on_upgrade_selected.bind(i))
		else:
			buttons[i].visible = false

	show()
	get_tree().paused = true


func _on_upgrade_selected(index):
	var upgrade = current_upgrades[index]

	player.upgrade_manager.apply_upgrade(upgrade)

	_close()


func _close():
	get_tree().paused = false
	hide()


func _format_upgrade(upgrade: UpgradeData) -> String:
	return "%s\n%s" % [upgrade.name, upgrade.description]
