class_name EquipmentManager
extends Node

@onready var weapon_slot: EquipmentSlot = $WeaponSlot
#@onready var defense_slot: EquipmentSlot = $DefenseSlot
#@onready var magic_slot: EquipmentSlot = $MagicSlot

#var slots := {}
var slots: Dictionary[SlotType.Type, EquipmentSlot] = {}

func _ready():
	EventBus.attack_requested.connect(_on_attack_requested)

	slots[SlotType.Type.WEAPON] = $WeaponSlot
	#slots["defense"] = $DefenseSlot
	#slots["magic"] = $MagicSlot


func equip(data: EquipmentData, player) -> void:
	var equipment = data.create_instance(player)
	var slot = slots[data.slot_type]

	slot.equip(equipment)


func _on_attack_requested() -> void:
	if weapon_slot.current_equipment:
		weapon_slot.current_equipment.try_attack()
