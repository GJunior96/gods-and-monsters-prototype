class_name CompositeHitPolicy
extends HitPolicy

@export var policies: Array[HitPolicy]

func apply(target: Node, context: Dictionary) -> void:
	for policy in policies:
		policy.apply(target, context)
