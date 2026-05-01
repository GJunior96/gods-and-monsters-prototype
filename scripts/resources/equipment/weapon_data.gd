class_name WeaponData
extends EquipmentData

@export var weapon_scene: PackedScene
@export var attack_pattern: AttackPattern
@export var attacks: Array[AttackData]

@export var cooldown: float = 0.5
@export var attack_range: float = 80
@export var modifiers: Array[Modifier]

@export var projectile_scene: PackedScene


func create_instance(player) -> EquipmentBase:
	var weapon: WeaponBase = weapon_scene.instantiate()
	weapon.setup(player, self)
	return weapon
