extends CharacterBody2D

@export var speed := 200.0
@export var max_life := 100
var life := max_life
var damage_cooldown := 0.5
var can_take_damage := true

@onready var weapon = $Weapon


func _physics_process(delta):

	weapon.try_shoot()

	var direction := Vector2.ZERO

	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	velocity = direction.normalized() * speed
	move_and_slide()


func take_damage(amount: int):
	if not can_take_damage:
		return

	can_take_damage = false

	life -= amount
	GlobalLogger.log("Player life: %s" % life)

	if life <= 0:
		GameManager.game_over()
		queue_free()

	await get_tree().create_timer(damage_cooldown).timeout
	can_take_damage = true
