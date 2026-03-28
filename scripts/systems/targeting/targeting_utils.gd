class_name TargetingUtils

static func _get_nearest_enemy(from: Vector2) -> Node2D:
	var enemies = Engine.get_main_loop().get_nodes_in_group("enemies")

	var nearest = null
	var min_dist = INF

	for enemmy in enemies:
		var dist = from.distance_to(enemmy.global_position)

		if dist < min_dist:
			min_dist = dist
			nearest = enemmy
	
	return nearest


static func get_direction(from: Vector2, to: Vector2) -> Vector2:
	return (to - from).normalized()
