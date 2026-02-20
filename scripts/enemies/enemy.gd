class_name Enemy
extends CharacterBody2D

@export var speed := 120.0
@export var target: Node2D
@export var life := 40
@export var xp_drop_scene: PackedScene
var dead := false

func _physics_process(delta):
	if dead or target == null:
		return

	var direction = (target.global_position - global_position). normalized()
	velocity = direction * speed
	move_and_slide()

	#for i in range(get_slide_collision_count()):
	#	var collision = get_slide_collision(i)
	#	if collision.get_collider().is_in_group("player"):
	#		collision.get_collider().take_damage(10)


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

	if xp_drop_scene:
		var xp = xp_drop_scene.instantiate()
		get_tree().current_scene.add_child(xp)
		xp.global_position = global_position

	GlobalLogger.log("Freeing: " + name)
	queue_free()


func _exit_tree():
	GlobalLogger.log("Enemy realmente removido: " + name)


func _on_hitbox_area_entered(area):
	if not area.is_in_group("player_hurtbox"):
		return

	if area.is_in_group("player_hurtbox"):
		GlobalLogger.log("DAMAGEEEEEEE", GlobalLogger.LogLevel.WARN)
		area.get_parent().take_damage(10)
