class_name ConeShapeData
extends ShapeData

@export var radius: float = 50.0
@export var angle: float = 90.0
@export var steps: int = 12

func generate() -> PackedVector2Array:
	return ShapeUtils.cone(radius,angle, steps)
