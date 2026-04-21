class_name UpgradeStat
extends UpgradeData

@export var life_bonus := 0
@export var speed_bonus := 0.0


func apply(player, stacks: int) -> void:
	player.max_life += life_bonus * stacks
	player.speed += speed_bonus * stacks
