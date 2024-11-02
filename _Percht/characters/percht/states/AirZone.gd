extends "res://_Percht/PerchtMove.gd"

var SPEED = "10"

func _frame_5():
	var force = xy_to_dir(data.x, data.y, SPEED)
	force.x = fixed.mul(force.x, str(host.get_facing_int()))
	
	host.apply_force_relative(force.x, force.y)
