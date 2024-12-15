extends "res://_Percht/PerchtMove.gd"

var delay = 1
var delay_left = 1

func _enter():	
	if data:
		delay = data.x
	
	delay_left = delay
	
func _frame_0():
	iasa_at = 22
	
	if host.is_grounded():
		host.apply_force_relative("2.0", "0.0")

func _frame_1():
	print("delay: ", delay)
	if delay == 0:
		current_tick = 11
		delay_left = 5
		iasa_at = 29
		
		var force = fixed.normalized_vec_times("0.75", "-1.0", "9.0")

		if !host.is_grounded():
			var vel = host.get_vel()

			vel = fixed.vec_mul(vel.x, vel.y, "0.5")
			host.set_vel(vel.x, vel.y)
			
			host.apply_force_relative(force.x, force.y)
		else:
			host.set_grounded(false)
			host.apply_force_relative(force.x, force.y)

func jump2():
	var force = fixed.normalized_vec_times("0.75", "-0.85", "7.0")
	force.x = fixed.mul(force.x, fixed.div(str(delay + 11), "12.0"))
	force.y = fixed.mul(force.y, fixed.div(str(delay + 29), "30.0"))
	
	print('test')
	
	if !host.is_grounded():
		var vel = host.get_vel()

		vel = fixed.vec_mul(vel.x, vel.y, "0.5")
		host.set_vel(vel.x, vel.y)
		
		host.apply_force_relative(force.x, force.y)
	else:
		host.set_grounded(false)
		host.apply_force_relative(force.x, force.y)
		
func _tick():
	if current_tick == 2:
		jump2() # Blame Ivy
	if current_tick == 11 and delay_left > 0:
		current_tick = 10
		delay_left -= 1

func _frame_14():
	var force = fixed.normalized_vec_times("1.0", "1.0", "5.0")
	print('test2')
	
	host.apply_force_relative(force.x, force.y)
