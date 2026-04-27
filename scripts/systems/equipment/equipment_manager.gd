class_name EquipmentManager
extends Node

@onready var weapon_slot: EquipmentSlot = $WeaponSlot
#@onready var defense_slot: EquipmentSlot = $DefenseSlot
#@onready var magic_slot: EquipmentSlot = $MagicSlot
var player: Node2D
#var slots := {}
var slots: Dictionary[SlotType.Type, EquipmentSlot] = {}
var global_modifiers: Array[AttackModifier] = []


func setup(_player: Node2D) -> void:
	player = _player


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
	var slot = slots[SlotType.Type.WEAPON]

	for eq in slot.equipments:
		if eq is WeaponBase:
			eq.try_attack()


func get_final_weapon_data(base_data: WeaponData) -> WeaponData:
	var final = base_data.duplicate(true)
	for mod in base_data.modifiers:
		mod.apply(final)

	for mod in player.upgrade_manager.get_modifiers():
		mod.apply(final)

	return final


func add_global_modifier(modifier: AttackModifier) -> void:
	global_modifiers.append(modifier)


func clear_global_modifiers() -> void:
	global_modifiers.clear()
