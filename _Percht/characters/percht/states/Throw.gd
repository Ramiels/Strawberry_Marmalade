extends "res://characters/states/ThrowState.gd"

func _enter():
	var next_state = ._enter()
	if host.kind == "Pretty":
		anim_name = "ForwardThrowPretty"
	if host.kind == "Ugly":
		anim_name = "ForwardThrowUgly"
	return next_state
