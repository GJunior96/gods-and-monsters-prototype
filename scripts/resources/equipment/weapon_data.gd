class_name WeaponData
extends EquipmentData

@export var weapon_scene: PackedScene
@export var attack_pattern: AttackPattern

@export var damage: int = 10
@export var cooldown: float = 0.5
@export var attack_radius: float = 80
@export var range: float = 500
@export var modifiers: Array[AttackModifier]

@export var projectile_scene: PackedScene


func create_instance(player) -> EquipmentBase:
	var weapon: WeaponBase = weapon_scene.instantiate()
	weapon.setup(player, self)
	return weapon
