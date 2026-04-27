class_name UpgradeAddEquipment
extends UpgradeData

@export var equipment: EquipmentData

func apply(player, manager) -> void:
	var stacks = manager.get_stack(id)
	if stacks == 1:
		player.equip(equipment)