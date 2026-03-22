class_name CooldownModifier
extends AttackModifier

@export var reduction: float

func apply(data: WeaponData) -> void:
	data.cooldown *= (1.0 - reduction)
