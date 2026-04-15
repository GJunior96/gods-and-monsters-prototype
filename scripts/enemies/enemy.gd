class_name Enemy
extends CharacterBody2D

@export var target: Node2D
@export var xp_drop_scene: PackedScene
@export var base_speed := 120.0
@export var base_damage := 15
@export var base_life := 40
@export var xp_value := 10
@export var min_spawn_time := 0.0

var dead := false
var life: int
var speed: float
var damage: int

# knockback vars ------------------------
@export var mass := 1.0
@export var friction := 500.0
# ---------------------------------------

# state vars -----------------------------
#@export var stun_duration := 0.15
var current_state: EnemyState
var chase_state: EnemyState
var stunned_state: EnemyState
var dead_state: EnemyState
var stun_timer := 0.15
@export var state_set: EnemyStateSet
# ---------------------------------------


func _ready():
	EnemyManager.register_enemy(self)

	if life == 0:
		setup(1.0)
	
	chase_state = EnemyChaseState.new().setup(state_set.chase)
	stunned_state = EnemyStunnedState.new().setup(state_set.stunned)
	dead_state = EnemyDeadState.new().setup(state_set.dead)
	
	change_state(chase_state)


func _physics_process(delta):
	if dead or target == null:
		return

	if current_state:
		current_state.physics_update(self, delta)


func setup(difficulty_multiplier: float):
	life = roundi(base_life * difficulty_multiplier)
	damage = roundi(base_damage * difficulty_multiplier)
	speed = base_speed * (1 + (difficulty_multiplier - 1) * 0.3)


func apply_knockback(direction: Vector2, force: float):
	if dead:
		return

	var knockback = direction.normalized() * (force / mass)
	velocity = knockback

	change_state(stunned_state)


func take_damage(amount: int):
	if dead:
		return

	life -= amount
	GlobalLogger.log("%s levou dano! Vida atual: %s" % [name,life])
	if life <= 0:
		die()


func die():
	dead = true

	change_state(dead_state)
	# Desliga colisao imediatamente
	$CollisionShape2D.disabled = true

	if xp_drop_scene:
		var xp = xp_drop_scene.instantiate()
		get_tree().current_scene.add_child(xp)
		xp.global_position = global_position
		xp.setup(xp_value)

	GlobalLogger.log("Freeing: " + name)
	EnemyManager.unregister_enemy(self)
	queue_free()


func change_state(new_state: EnemyState):
	if current_state:
		current_state.exit(self)
	
	current_state = new_state

	if current_state:
		current_state.enter(self)


func _exit_tree():
	GlobalLogger.log("Enemy realmente removido: " + name)


func _on_hitbox_area_entered(area):
	if not area.is_in_group("player_hurtbox"):
		return

	if area.is_in_group("player_hurtbox"):
		area.get_parent().take_damage(damage)
