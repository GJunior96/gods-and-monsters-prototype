class_name UpgradeStat
extends UpgradeData

@export var life_bonus := 0
@export var speed_bonus := 0.0


func apply(player, manager) -> void:
	var stacks = manager.get_stack(id)
	player.max_life += life_bonus * stacks
	player.speed += speed_bonus * stacks
