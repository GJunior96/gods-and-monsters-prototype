class_name UpgradeAddEquipment
extends UpgradeData

@export var equipment: EquipmentData

func apply(player, stacks: int) -> void:
	if stacks == 1:
		player.equip(equipment)