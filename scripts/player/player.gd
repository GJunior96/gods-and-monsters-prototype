extends CharacterBody2D

@export var speed := 200.0
@export var max_life := 100
var life := max_life
var damage_cooldown := 0.5
var can_take_damage := true

func _physics_process(delta):
	var direction := Vector2.ZERO

	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	velocity = direction.normalized() * speed
	move_and_slide()

	_check_enemy_collision()


func _check_enemy_collision():
	if not can_take_damage:
		return

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider and collider.is_in_group("enemies"):
			take_damage(10)
			break

func take_damage(amount: int):
	life -= amount
	can_take_damage = false
	print("Player life:", life)

	await get_tree().create_timer(damage_cooldown).timeout
	can_take_damage = true
