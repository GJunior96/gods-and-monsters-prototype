class_name UpgradeAddModifier
extends UpgradeData

@export var modifier: AttackModifier

func apply(player, manager) -> void:
	var stacks = manager.get_stack(id)
	for i in range(stacks):
		player.equipment_manager.add_global_modifier(modifier)
