class_name ArcShapeData
extends ShapeData

@export var radius: float = 50
@export var thickness: float = 12
@export var angle: float = 90

func generate() -> PackedVector2Array:
	return ShapeUtils.arc(radius, thickness, angle)

func get_inner_radius() -> float:
	return radius - thickness
