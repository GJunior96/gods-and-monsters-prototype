class_name DamageModifier
extends Modifier

@export var bonus_damage: int
@export var type: ModifierType.Type = ModifierType.Type.ADDITIVE

func apply(data: WeaponData):
	match type:
		ModifierType.Type.ADDITIVE:
			data.damage += bonus_damage
		ModifierType.Type.MULTIPLICATIVE:
			data.damage *= bonus_damage