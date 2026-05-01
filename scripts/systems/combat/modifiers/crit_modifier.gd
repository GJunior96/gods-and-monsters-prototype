class_name CritModifier
extends Modifier

@export var chance: float = 0.2
@export var multiplier: float = 2.0


func apply(data: WeaponData) -> void:
	data.crit_chance += chance
	data.crit_multiplier *= multiplier
