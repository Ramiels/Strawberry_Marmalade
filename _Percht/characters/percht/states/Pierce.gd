extends "res://_Percht/PerchtMove.gd"

func _enter():
	host.apply_force_relative("9.0", "0.0")
	
func _frame_12():
	host.apply_force_relative("10.0", "0.0")
