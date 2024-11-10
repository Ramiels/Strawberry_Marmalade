extends "res://_Percht/PerchtMove.gd"

export var JUMP_FORCE = "-5.0"
export var JUMP_FRAME = 9
	
func _tick():
	if current_tick == JUMP_FRAME - 1:
		host.set_grounded(false)
	if current_tick == JUMP_FRAME - 1:
		host.apply_force("0.0", "-5.0")
		
	._tick()
