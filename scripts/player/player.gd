class_name Player
extends CharacterBody2D

@onready var equipment_manager = $EquipmentManager

@export var speed := 200.0
@export var max_life := 100
@export var starting_equipment_id: String

var life := max_life
var damage_cooldown := 0.5
var can_take_damage := true
var level: int = 1
var xp: int = 0
var xp_to_next_level: int = 20

# targeting vars
@export var target_update_interval := 0.2
var _target_timer := 0.0
var current_target: Node2D
var attack_direction: Vector2 = Vector2.RIGHT

# weapon draw vars
var show_attack_debug := true
var attack_range
var attack_radius
var attack_thickness
var attack_angle

signal xp_changed(current, max)
signal leveled_up(new_level)
signal game_over
signal on_attack
signal on_kill
signal on_damage_taken

 
func _ready():
	var equipment_data = ItemDatabase.get_item(starting_equipment_id)

	# attack_range = equipment_data.attack_range
	# attack_radius = equipment_data.shape.radius
	# attack_thickness = equipment_data.shape.thickness
	# attack_angle = equipment_data.shape.angle


	equip(equipment_data)


func _process(delta):
	_target_timer += delta

	if _target_timer >= target_update_interval:
		update_target()
		_target_timer = 0.0

	# if show_attack_debug:
	# 	queue_redraw()


func _physics_process(_delta):

	handle_movement()
	handle_attack()


func update_target():
	current_target = TargetingUtils._get_nearest_enemy(global_position)

	if current_target:
		attack_direction = TargetingUtils.get_direction(current_target.global_position, global_position)


# func _draw():
# 	if not show_attack_debug and not attack_range and not attack_radius and not attack_direction:
# 		return

# 	var base_points = ShapeUtils.arc(attack_radius, attack_thickness, attack_angle, 12)
# 	var rotated_points := []

# 	var rot = attack_direction.angle()

# 	for point in base_points:
# 		rotated_points.append(point.rotated(rot))

# 	draw_polygon(rotated_points, [Color("#ffd90080")])

# 	draw_line(Vector2.ZERO, attack_direction * attack_range, Color.GREEN, 3) # direcao do ataque
# 	draw_circle(Vector2.ZERO, attack_range, Color(1, 0, 0, 0.2)) # range do ataque



# func _draw_attack_cone():
# 	var points = ShapeUtils.arc(attack_radius, attack_thickness, attack_angle, 12)
# 	#draw_colored_polygon(points, attack_direction, Color(1, 1, 0, 0.3))


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
