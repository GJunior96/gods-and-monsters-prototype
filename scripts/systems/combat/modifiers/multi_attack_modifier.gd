class_name MultiAttackModifier
extends Modifier

@export var extra_attacks: int = 1

func apply(data: WeaponData) -> void:
	data.extra_attacks = data.attacks.duplicate(true)

	for i in range(extra_attacks):
		data.extra_attacks.append(data.attacks[i])
