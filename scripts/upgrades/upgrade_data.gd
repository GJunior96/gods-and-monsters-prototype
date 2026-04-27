class_name UpgradeData
extends Resource

const TYPE := "UpgradeData"
@export var id: String
@export var name: String
@export var description: String

@export var rarity: int = 1
@export var weight := 1.0
@export var tags: Array[String] = []

@export var max_stacks: int = 1


func can_offer(player, manager) -> bool:
    var stacks = manager.get_stack(id)
    return stacks < max_stacks


func apply(player, manager) -> void:
    pass
    