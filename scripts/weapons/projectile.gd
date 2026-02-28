extends Area2D

var speed: float
var damage: float

var direction: Vector2 = Vector2.ZERO

func _physics_process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if not body is Enemy:
		return

	if body is Enemy:
		GlobalLogger.log("Projectile hit: %s | Groups: %s" % [body.name, body.get_groups()])
		body.take_damage(damage)
		queue_free()
