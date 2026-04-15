class_name EnemyChaseState
extends EnemyState

func physics_update(_enemy, _delta):
	if _enemy.dead or _enemy.target == null:
		return

	var direction = (_enemy.target.global_position - _enemy.global_position). normalized()
	var desired_velocity = direction * _enemy.speed * data.speed_multiplier

	# Aplica fricção
	_enemy.velocity = _enemy.velocity.move_toward(desired_velocity, data.friction * _delta)
	_enemy.move_and_slide()
