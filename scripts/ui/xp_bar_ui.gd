extends Node

@onready var xp_bar = $TextureProgressBar

func _ready():
	var player = get_tree().get_first_node_in_group("player")
	player.connect("xp_changed", _on_xp_changed)


func _on_xp_changed(current, max):
	xp_bar.max_value = max
	xp_bar.value = current
