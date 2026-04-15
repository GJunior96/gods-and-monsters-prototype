class_name EnemyDeadState
extends EnemyState

func enter(enemy):
	enemy.velocity = Vector2.ZERO
	enemy.set_physics_process(false)
