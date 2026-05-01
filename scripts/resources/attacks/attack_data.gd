class_name AttackData
extends Resource

@export var attack_scene: PackedScene
@export var hit_policy: HitPolicy
@export var damage: float = 10.0
@export var knockback_force: float = 150.0

@export var shape: ShapeData
@export var hit_shape: ShapeData

@export var attack_duration: float = 0.12
@export var hit_start: float = 0.2
@export var hit_end: float = 0.5

@export var crit_chance: float = 0.0
@export var crit_multiplier: float = 1.0

@export var chain_count: int = 0
@export var split_count: int = 0
@export var split_angle: float = 0.0

@export var swing_angle: float = 90.0