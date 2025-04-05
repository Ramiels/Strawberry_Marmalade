extends "res://_Percht/PerchtMove.gd"

func _enter():
	host.colliding_with_opponent = false
	
func _frame_0():
	host.z_index = - 2

func _frame_10():
	apply_fric = true

func _frame_15():
	host.colliding_with_opponent = true
	
