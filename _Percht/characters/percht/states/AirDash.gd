extends "res://characters/states/AirDash.gd"

func _tick():
	var next_state = ._tick()
	anim_name = anim_name + host.kind
	return next_state
