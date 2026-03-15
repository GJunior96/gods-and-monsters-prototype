extends Node

var enemies: Array = []

func register_enemy(enemy: Enemy):
	enemies.append(enemy)


func unregister_enemy(enemy: Enemy):
	enemies.erase(enemy)

