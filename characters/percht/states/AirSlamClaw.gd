extends "res://_Percht/PerchtMove.gd"

export var JUMP_FORCE = "-5.0"
export var FALL_FORCE = "15.0"
export var JUMP_FRAME = 9

var fallen = false

func _frame_0():
	fallen = false

func _frame_1():
	host.apply_force("0.0", FALL_FORCE)

func _tick():
	if current_tick >= 3 and not fallen:
		current_tick = 2
		if host.is_grounded():
			fallen = true
	
	if current_tick == JUMP_FRAME - 1:
		host.set_grounded(false)
	if current_tick == JUMP_FRAME - 1:
		host.apply_force("0.0", JUMP_FORCE)
		
	._tick()
