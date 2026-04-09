class_name WeaponData
extends EquipmentData

@export var weapon_scene: PackedScene
@export var attack_pattern: AttackPattern
@export var attack_scene: PackedScene

@export var damage: int = 10
@export var cooldown: float = 0.5
@export var attack_range: float = 80
@export var attack_duration: float = 0.12
@export var modifiers: Array[AttackModifier]

# Slash
# @export var slash_radius: float = 50.0
# @export var slash_thickness: float = 12.0
# @export var slash_angle: float = 90.0

@export var swing_angle: float = 90.0
@export var hit_start: float = 0.4
@export var hit_end: float = 0.6
@export var shape: ShapeData

@export var projectile_scene: PackedScene


func create_instance(player) -> EquipmentBase:
	var weapon: WeaponBase = weapon_scene.instantiate()
	weapon.setup(player, self)
	return weapon
