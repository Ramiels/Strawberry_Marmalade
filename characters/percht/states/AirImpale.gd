extends "res://_Percht/PerchtMove.gd"

const DESCEND_SPEED = "18"

const MIN_VERT_SPEED = "0"
const MAX_VERT_SPEED = "3"

var descending = false

func _frame_0():
	descending = false
	if data:
		var amount = fixed.div(str(data.x * host.get_facing_int()), "100")
		amount = fixed.lerp_string(MIN_VERT_SPEED, MAX_VERT_SPEED, amount)
		host.set_vel(fixed.add(fixed.mul(host.get_vel().x, "0.9"), amount), "-5.0")


func _frame_7():
	descending = true


func _tick():
	if descending:
		host.set_vel(fixed.mul(host.get_vel().x, "0.5"), DESCEND_SPEED)
		descending = false
	
	if host.is_grounded():
		queue_state_change("Landing", 3)




func on_got_perfect_parried():
	host.hitlag_ticks += 4
