class_name CooldownModifier
extends Modifier

@export var reduction: float = 0.9
@export var type: ModifierType.Type = ModifierType.Type.MULTIPLICATIVE

func apply(data: WeaponData) -> void:
	match type:
		ModifierType.Type.ADDITIVE:
			data.cooldown += reduction
		ModifierType.Type.MULTIPLICATIVE:
			data.cooldown *= reduction
