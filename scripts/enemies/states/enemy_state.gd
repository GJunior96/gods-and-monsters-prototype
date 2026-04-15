class_name EnemyState
extends RefCounted

var data: EnemyStateData

func setup(state_data: EnemyStateData):
    data = state_data
    return self
    

func enter(_enemy): pass
func exit(_enemy): pass
func physics_update(_enemy, _delta): pass
