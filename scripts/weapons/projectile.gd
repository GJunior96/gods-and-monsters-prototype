extends Area2D

@export var speed := 450.0
@export var damage := 20

var direction: Vector2 = Vector2.ZERO

func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(damage)
		queue_free()
