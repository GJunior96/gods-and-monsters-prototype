class_name EquipmentSlot
extends Node2D


@export var slot_type: SlotType.Type

var current_equipment: EquipmentBase


func equip(equipment: EquipmentBase) -> void:
	if current_equipment:
		current_equipment.queue_free()

	current_equipment = equipment
	add_child(equipment)
