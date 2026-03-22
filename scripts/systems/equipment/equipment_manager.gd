class_name EquipmentManager
extends Node

@onready var weapon_slot: EquipmentSlot = $WeaponSlot
#@onready var defense_slot: EquipmentSlot = $DefenseSlot
#@onready var magic_slot: EquipmentSlot = $MagicSlot

#var slots := {}
var slots: Dictionary[SlotType.Type, EquipmentSlot] = {}

func _ready():
	slots[SlotType.Type.WEAPON] = $WeaponSlot
	#slots["defense"] = $DefenseSlot
	#slots["magic"] = $MagicSlot


func equip(data: EquipmentData, player) -> void:
	var equipment = data.create_instance(player)
	var slot = slots[data.slot_type]

	slot.equip(equipment)


func try_attack() -> void:
	if weapon_slot.current_equipment:
		weapon_slot.current_equipment.try_attack()
