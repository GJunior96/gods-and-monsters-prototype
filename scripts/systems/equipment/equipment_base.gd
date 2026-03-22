class_name EquipmentBase
extends Node2D

var player: Node2D
var data: EquipmentData

func setup(player_node: Node2D, equipment_data: EquipmentData) -> void:
	player = player_node
	data = equipment_data
