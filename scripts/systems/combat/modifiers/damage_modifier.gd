class_name DamageModifier
extends AttackModifier

@export var bonus_damage: int

func apply(data: WeaponData):
	data.damage += bonus_damage