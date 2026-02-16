class_name Enemy
extends CharacterBody2D

@export var speed := 120.0
@export var target: Node2D
@export var life := 40
var dead := false

func _physics_process(delta):
	if dead or target == null:
		return

	var direction = (target.global_position - global_position). normalized()
	velocity = direction * speed
	move_and_slide()

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("player"):
			collision.get_collider().take_damage(10)


func take_damage(amount: int):
	if dead:
		return

	life -= amount
	GlobalLogger.log("Inimigo levou dano! Vida atual: %s" % life)
	if life <= 0:
		die()


func die():
	dead = true

	# Para o movimento
	velocity = Vector2.ZERO
	set_physics_process(false)

	# Desliga colisao imediatamente
	$CollisionShape2D.disabled = true

	GlobalLogger.log("Freeing: " + name)
	queue_free()


func _exit_tree():
	GlobalLogger.log("Enemy realmente removido: " + name)
