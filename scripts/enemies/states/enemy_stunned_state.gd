class_name EnemyStunnedState
extends EnemyState

var timer := 0.0

func enter(enemy):
	timer = data.duration

	if data.stop_on_enter:
		enemy.velocity = Vector2.ZERO


func physics_update(enemy, delta):
	timer -= delta

	enemy.velocity = enemy.velocity.move_toward(Vector2.ZERO, data.friction * delta)
	enemy.move_and_slide()

	if timer <= 0:
		enemy.change_state(enemy.chase_state)