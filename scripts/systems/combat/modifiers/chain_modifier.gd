class_name ChainModifier
extends Modifier

@export var chains: int = 2

func apply(data: WeaponData) -> void:
	data.chain_count = chains
