extends "res://characters/states/Jump.gd"

func _tick():
	var next_state = ._tick()
	anim_name = anim_name + host.kind
	return next_state
