extends CanvasLayer

@onready var player = get_tree().get_first_node_in_group("player")

signal upgrade_finished

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

	GameManager.request_upgrade_screen.connect(show_upgrade)


func show_upgrade():
	visible = true


func hide_upgrade():
	visible = false


func _on_upgrade_damage_pressed() -> void:
	if player:
		player.weapon.upgrade("damage", 2)

	upgrade_finished.emit()
	hide_upgrade()


func _on_upgrade_speed_pressed() -> void:
	if player:
		player.weapon.upgrade("speed", 2)

	upgrade_finished.emit()
	hide_upgrade()


func _on_upgrade_fire_rate_pressed() -> void:
	if player:
		player.weapon.upgrade("fire_rate", 0.8)

	upgrade_finished.emit()
	hide_upgrade()
