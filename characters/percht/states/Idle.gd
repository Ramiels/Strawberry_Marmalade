extends "res://characters/states/Idle.gd"

func _enter():
	var next_state = ._enter()
	if host.kind == "Pretty":
		anim_name = "WaitPretty"
	if host.kind == "Ugly":
		anim_name = "WaitUgly"
	return next_state
