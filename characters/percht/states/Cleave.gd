extends "res://_Percht/PerchtMove.gd"

func _enter():
	host.apply_force_relative("4.0", "0.0")
	
func _frame_20():
	host.apply_force_relative("5.0", "0.0")
