extends "res://_Percht/PerchtMove.gd"

const DESCEND_SPEED = "20"

var descending = false

func _frame_0():
	descending = false
	host.set_vel(fixed.mul(host.get_vel().x, "0.8"), "-5.0")


func _frame_5():
	descending = true


func _tick():
	if descending:
		host.set_vel(fixed.mul(host.get_vel().x, "0.5"), DESCEND_SPEED)
		descending = false
	
	if host.is_grounded():
		queue_state_change("Landing", 6)




func on_got_perfect_parried():
	host.hitlag_ticks += 4
