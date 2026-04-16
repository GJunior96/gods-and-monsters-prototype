class_name DamagePolicy
extends HitPolicy

func apply(target: Node, context: Dictionary) -> void:
	if target.has_method("take_damage"):
		target.take_damage(context.damage)
