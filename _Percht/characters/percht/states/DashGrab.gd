extends "res://_Percht/PerchtMove.gd"

var SPEED = "1.3"

func _frame_4():
	host.colliding_with_opponent = false

func _frame_6():
	var vel_x = fixed.mul(str(data.x + 20), SPEED)
	#print(vel_x)
	host.apply_force_relative(vel_x, "0")
	host.start_invulnerability()

func _frame_7():
	host.set_vel(fixed.mul(host.get_vel().x, "0.2"), "0")

func _frame_8():
	host.set_vel(fixed.mul(host.get_vel().x, "0.2"), "0")
	host.end_invulnerability()

func _frame_10():
	host.colliding_with_opponent = true

func _exit():
	host.end_invulnerability()
	host.colliding_with_opponent = true
