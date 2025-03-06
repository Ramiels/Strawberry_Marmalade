extends "res://_Percht/PerchtMove.gd"

func _frame_5():
	host.apply_force_relative("7.0", "0.0")
	
func _frame_13():
	host.apply_force_relative("8.0", "0.0")

func _tick():
	host.whip_combo = true
