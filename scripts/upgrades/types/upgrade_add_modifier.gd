class_name UpgradeAddModifier
extends UpgradeData

@export var modifier: Modifier

func apply(_player, manager) -> void:
	var stacks = manager.get_stack(id)
	for i in range(stacks):
		manager.add_global_modifier(modifier)
