extends Node2D

@onready var hit_area: Area2D = $Area2D
@onready var collision: CollisionPolygon2D = $Area2D/CollisionPolygon2D
@onready var inner_area: Area2D = $InnerArea2D

@export var is_debug := false

var duration
var hit_start
var hit_end
var radius
var thickness
var angle
var swing_angle

var data: AttackData

var _time := 0.0
var _start_rotation := 0.0
var base_rotation := 0.0
var _hit_active := false

signal hit_detected(targets: Array)


func _ready() -> void:
	_set_hit_active(false)
	
	_time = 0.0
	queue_redraw()

	if not hit_area.area_entered.is_connected(_on_area_2d_area_entered):
		hit_area.area_entered.connect(_on_area_2d_area_entered)

	if not inner_area.area_entered.is_connected(_on_inner_area_2d_area_entered):
		inner_area.area_entered.connect(_on_inner_area_2d_area_entered)


func _draw() -> void:
	var points = data.shape.generate()
	draw_polygon(points, [Color.WHITE])

	# DEBUG
	if is_debug:
		draw_line(Vector2.ZERO, Vector2.RIGHT * radius, Color.RED, 3) # frente
		draw_line(Vector2.ZERO, Vector2.UP * radius, Color.BLUE, 2) # cima
		draw_line(Vector2.ZERO, Vector2.RIGHT * 50, Color.GREEN, 3) # direcao do ataque
		draw_circle(Vector2.ZERO, 5, Color.GREEN) # centro do slash
		draw_circle(Vector2.ZERO, radius - thickness, Color.RED) # inner radius


func _process(delta: float) -> void:
	_time += delta
	var t = _time / duration

	# animacao rotacao
	var swing = lerp_angle(_start_rotation, _start_rotation + deg_to_rad(swing_angle), t)

	rotation = base_rotation + swing

	# hit frame
	if not _hit_active and t >= hit_start:
		_set_hit_active(true)

	if _hit_active and t >= hit_end:
		_set_hit_active(false)

	modulate.a = 1.0 - t
	if t >= 1.0:
		queue_free()


func setup(direction: Vector2, attack_data: AttackData) -> void:
	data = attack_data
	base_rotation = direction.angle() + PI

	radius = data.shape.radius
	thickness = data.shape.thickness
	angle = data.shape.angle

	swing_angle = data.swing_angle
	duration = data.attack_duration
	hit_start = data.hit_start
	hit_end = data.hit_end

	collision.polygon = data.shape.generate()
	_start_rotation = -deg_to_rad(swing_angle / 2)

	var inner_radius = data.shape.get_inner_radius()
	var col = inner_area.get_node("CollisionShape2D")

	if col.shape:
		col.shape.radius = inner_radius
	else:
		push_error("InnerArea has no shape assigned")


func _set_hit_active(active: bool) -> void:
	_hit_active = active
	if hit_area:
		hit_area.monitoring = active
	if inner_area:
		inner_area.monitoring = active


func _generate_arc_points() -> PackedVector2Array:
	var points := []

	var  start_angle = deg_to_rad(-angle / 2)
	var end_angle = deg_to_rad(angle / 2)
	var steps = 12

	for i in range(steps + 1):
		var t = i / float(steps)
		var a = lerp(start_angle, end_angle, t)

		var outer = Vector2(cos(a), -sin(a)) * radius

		points.append(outer)

	for i in range(steps, -1, -1):
		var t = i/ float(steps)
		var a = lerp(start_angle, end_angle, t)

		var inner = Vector2(cos(a), sin(a)) * (radius - thickness)

		points.append(inner)

	return points


func _on_area_2d_area_entered(area: Area2D) -> void:
	if not _hit_active:
		return
	
	var enemy = area.get_parent()

	if enemy is Enemy:
		#_try_hit(enemy)
		hit_detected.emit([enemy])


func _on_inner_area_2d_area_entered(area: Area2D) -> void:
	if not _hit_active:
		return

	var enemy = area.get_parent()

	if enemy is Enemy: # and not _already_hit.has(enemy):
		#_try_hit(enemy)
		hit_detected.emit([enemy])
