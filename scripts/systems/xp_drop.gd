extends Area2D

var xp_value := 1

func setup(value):
	xp_value = value

func _on_body_entered(body):
	if body is Player:
		body.gain_xp(xp_value)
		queue_free()
