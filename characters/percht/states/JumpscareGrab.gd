extends "res://_Percht/PerchtMove.gd"

var SPEED = "8.0"
var VEL_X_MULT = "2.2"
var VEL_Y = "-2.5"

func _frame_1():
	host.set_grounded(false)
	var vel_x = host.get_vel().x
	vel_x = fixed.mul(vel_x, VEL_X_MULT)
	vel_x = fixed.abs(vel_x)
	vel_x = fixed.add(vel_x, SPEED)
	host.set_vel("0.0", "0.0")
	host.apply_force_relative(vel_x, VEL_Y)

func _tick():
	if current_tick > 2 and host.is_grounded():
		return "HardKnockdown"
