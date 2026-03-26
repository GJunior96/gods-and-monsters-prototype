class_name EquipmentData
extends Resource

@export var id: String
@export var name: String
@export var description: String
@export var icon: Texture2D
@export var slot_type: SlotType.Type


func create_instance(player) -> EquipmentBase:
	return null
