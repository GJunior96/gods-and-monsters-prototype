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


func _ready():
	EnemyManager.register_enemy(self)

	if life == 0:
		setup(1.0)


func _physics_process(delta):
	if dead or target == null:
		return

	var direction = (target.global_position - global_position). normalized()
	velocity = direction * speed
	move_and_slide()


func setup(difficulty_multiplier: float):
	life = roundi(base_life * difficulty_multiplier)
	damage = roundi(base_damage * difficulty_multiplier)
	speed = base_speed * (1 + (difficulty_multiplier - 1) * 0.3)


func take_damage(amount: int):
	if dead:
		return

	life -= amount
	GlobalLogger.log("%s levou dano! Vida atual: %s" % [name,life])
	if life <= 0:
		die()


func die():
	dead = true

	# Para o movimento
	velocity = Vector2.ZERO
	set_physics_process(false)

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


func _exit_tree():
	GlobalLogger.log("Enemy realmente removido: " + name)


func _on_hitbox_area_entered(area):
	if not area.is_in_group("player_hurtbox"):
		return

	if area.is_in_group("player_hurtbox"):
		area.get_parent().take_damage(damage)
