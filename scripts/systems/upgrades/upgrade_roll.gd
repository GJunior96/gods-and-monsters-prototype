class_name UpgradeRoll

static func roll_upgrades(player, count := 3) -> Array:
	var pool = UpgradeDatabase.get_available(player, player.upgrade_manager)

	var result := []

	for i in range(count):
		if pool.is_empty():
			break
		
		var chosen = _weighted_random(pool)
		result.append(chosen)
		pool.erase(chosen)

	return result


static func _weighted_random(list):
	var total_weight = 0.0
	for item in list:
		total_weight += item.weight

	var r = randf() * total_weight

	for item in list:
		r -= item.weight
		if r <= 0:
			return item

	return list[0] # Fallback, should not happen
