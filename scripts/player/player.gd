class_name Player
extends CharacterBody2D

@export var speed := 200.0
@export var max_life := 100
var life := max_life
var damage_cooldown := 0.5
var can_take_damage := true
var level: int = 1
var xp: int = 0
var xp_to_next_level: int = 20

@onready var weapon = $Weapon

signal xp_changed(current, max)
signal leveled_up(new_level)


func _physics_process(delta):

	weapon.try_shoot()

	var direction := Vector2.ZERO

	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	velocity = direction.normalized() * speed
	move_and_slide()


func take_damage(amount: int):
	if not can_take_damage:
		GlobalLogger.log("Aguardando cooldown de dano...", GlobalLogger.LogLevel.WARN)
		return

	can_take_damage = false

	life -= amount
	GlobalLogger.log("Player life: %s" % life)

	if life <= 0:
		GameManager.game_over()
		queue_free()

	await get_tree().create_timer(damage_cooldown).timeout
	can_take_damage = true


func gain_xp(amount: int):
	xp += amount

	if xp >= xp_to_next_level:
		level_up()

	emit_signal("xp_changed", xp, xp_to_next_level)


func level_up():
	level += 1
	xp = xp - xp_to_next_level
	xp_to_next_level = int(100 * pow(level, 1.5))

	GlobalLogger.log("LEVELUP")

	emit_signal("leveled_up", level)

	
