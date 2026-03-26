class_name Player
extends CharacterBody2D

@export var speed := 200.0
@export var max_life := 100
#@export var starting_equipment: EquipmentData
var life := max_life
var damage_cooldown := 0.5
var can_take_damage := true
var level: int = 1
var xp: int = 0
var xp_to_next_level: int = 20
@export var starting_equipment_id: String

@onready var equipment_manager = $EquipmentManager

signal xp_changed(current, max)
signal leveled_up(new_level)
signal game_over
signal on_attack
signal on_kill
signal on_damage_taken


func _ready():
	var equipment_data = ItemDatabase.get_item(starting_equipment_id)
	equip(equipment_data)
	#if starting_equipment:
	#	equip(starting_equipment)


func _physics_process(delta):

	handle_movement()
	handle_attack()


func handle_movement() -> void:
	var direction := Vector2.ZERO

	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	velocity = direction.normalized() * speed
	move_and_slide()


func handle_attack() -> void:
	if Input.is_action_pressed("attack"):
		EventBus.attack_requested.emit()
		

func take_damage(amount: int):
	if not can_take_damage:
		GlobalLogger.log("PLAYER damage cooldown", GlobalLogger.LogLevel.WARN)
		return

	can_take_damage = false

	life -= amount
	on_damage_taken.emit()
	GlobalLogger.log("Player life: %s" % life)

	if life <= 0:
		game_over.emit()
		queue_free()

	await get_tree().create_timer(damage_cooldown).timeout
	can_take_damage = true


func gain_xp(amount: int):
	xp += amount

	while xp >= xp_to_next_level:
		level_up()

	emit_signal("xp_changed", xp, xp_to_next_level)


func level_up():
	level += 1
	xp = xp - xp_to_next_level
	xp_to_next_level = int(100 * pow(1.12, level - 1))

	GlobalLogger.log("LEVELUP")

	leveled_up.emit(level)


func equip(data: EquipmentData) -> void:
	equipment_manager.equip(data, self)
