extends CharacterBody2D

@export var speed := 120.0
@export var target: Node2D
@export var life := 40

func _physics_process(delta):
	if target == null:
		return

	var direction = (target.global_position - global_position). normalized()
	velocity = direction * speed
	move_and_slide()

func take_damage(amount: int):
	life -= amount
	print("Inimigo levou dano! Vida atual:", life)
	if life <= 0:
		queue_free()
