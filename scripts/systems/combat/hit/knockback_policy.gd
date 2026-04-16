class_name KnockbackPolicy
extends HitPolicy

func apply(target: Node, context: Dictionary) -> void:
	if target.has_method("apply_knockback"):
		target.apply_knockback(context.direction, context.knockback)
