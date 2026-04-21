class_name UpgradeAddModifier
extends UpgradeData

@export var modifier: AttackModifier

func apply(player, stacks: int) -> void:
	for i in stacks:
		player.equipment_manager.add_global_modifier(modifier)
