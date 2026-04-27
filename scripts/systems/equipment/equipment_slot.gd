class_name EquipmentSlot
extends Node2D


@export var slot_type: SlotType.Type
@export var is_multi := false

var equipments: Array[EquipmentBase] = []


func equip(equipment: EquipmentBase) -> void:
	if is_multi:
		equipments.append(equipment)
		add_child(equipment)
	else:
		if equipments.size() > 0:
			equipments[0].queue_free()
			equipments.clear()

		equipments.append(equipment)
		add_child(equipment)

