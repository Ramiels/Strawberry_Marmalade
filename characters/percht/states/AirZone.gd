extends "res://_Percht/PerchtMove.gd"


func _enter():
	._enter()
	if host.air_zone_float:
		apply_grav = false
		host.air_zone_float = false
	else:
		apply_grav = true

func _tick_0():
	landing_recovery = 3
	land_cancel = true
	

func _frame_1():
	if host.quickswap:
		land_cancel = false

func on_got_perfect_parried():
	landing_recovery = 6
