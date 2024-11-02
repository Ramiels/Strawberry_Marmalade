extends "res://_Percht/PerchtMove.gd"

func _enter():	
	if host.is_grounded():
		host.apply_force_relative("2.0", "0.0")

func _frame_6():
	if !host.is_grounded():
		var vel = host.get_vel()

		vel = fixed.vec_mul(vel.x, vel.y, "0.5")
		host.set_vel(vel.x, vel.y)

		var force = fixed.normalized_vec_times("1.0", "-0.75", "5.0")
		host.apply_force_relative(force.x, force.y)
	else:
		host.apply_force_relative("4.0", "0.0")
		
		
