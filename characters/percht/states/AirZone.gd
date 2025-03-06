extends "res://_Percht/PerchtMove.gd"

func _tick_0():
	landing_recovery = 3
	land_cancel = true

func _frame_1():
	if host.quickswap:
		land_cancel = false

func on_got_perfect_parried():
	landing_recovery = 6
