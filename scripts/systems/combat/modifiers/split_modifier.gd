class_name SplitModifier
extends Modifier

@export var count: int = 2
@export var angle: float = 15.0

func apply(data: WeaponData) -> void:
	data.split_count = count
	data.split_angle = angle
