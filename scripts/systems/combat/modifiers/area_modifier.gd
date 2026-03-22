class_name AreaModifier
extends AttackModifier

@export var bonus_radius: float

func apply(data: WeaponData) -> void:
	data.attack_radius += bonus_radius
