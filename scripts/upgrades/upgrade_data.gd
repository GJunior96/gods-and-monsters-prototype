class_name UpgradeData
extends Resource

@export var id: String
@export var name: String
@export var description: String

@export var rarity: int = 1
@export var tags: Array[String] = []

@export var max_stacks: int = 1

func apply(player, stacks: int) -> void:
    # This method should be overridden by specific upgrade implementations
    pass