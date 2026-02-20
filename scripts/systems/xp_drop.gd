extends Area2D

@export var xp_value := 10

func _on_body_entered(body):
	if body is Player:
		body.gain_xp(xp_value)
		queue_free()
