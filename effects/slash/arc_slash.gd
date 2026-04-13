extends Node2D

@onready var hit_area: Area2D = $Area2D
@onready var collision: CollisionPolygon2D = $Area2D/CollisionPolygon2D
@onready var inner_area: Area2D = $InnerArea2D

@export var is_debug := false

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


func _draw() -> void:
	var points = data.shape.generate()
	draw_polygon(points, [Color.WHITE])

	# DEBUG
	if is_debug:
		draw_line(Vector2.ZERO, Vector2.RIGHT * data.shape.radius, Color.RED, 3) # frente
		draw_line(Vector2.ZERO, Vector2.UP * data.shape.radius, Color.BLUE, 2) # cima
		draw_line(Vector2.ZERO, Vector2.RIGHT * 50, Color.GREEN, 3) # direcao do ataque
		draw_circle(Vector2.ZERO, 5, Color.GREEN) # centro do slash


func _process(delta: float) -> void:
	_time += delta
	var t = _time / data.attack_duration

	# animacao rotacao
	var swing = lerp_angle(_start_rotation, _start_rotation + deg_to_rad(data.swing_angle), t)

	rotation = base_rotation + swing

	# hit frame
	if not _hit_active and t >= data.hit_start:
		_set_hit_active(true)

	if _hit_active and t >= data.hit_end:
		_set_hit_active(false)

	modulate.a = 1.0 - t
	if t >= 1.0:
		queue_free()


func setup(direction: Vector2, attack_data: AttackData) -> void:
	data = attack_data
	base_rotation = direction.angle() + PI

	if data and data.hit_shape:
		collision.polygon = data.hit_shape.generate()
	_start_rotation = -deg_to_rad(data.swing_angle / 2)


func _set_hit_active(active: bool) -> void:
	_hit_active = active
	if hit_area:
		hit_area.monitoring = active
	if inner_area:
		inner_area.monitoring = active


func _on_area_2d_area_entered(area: Area2D) -> void:
	if not _hit_active:
		return
	
	var enemy = area.get_parent()

	if enemy is Enemy:
		hit_detected.emit([enemy])
