extends "res://characters/states/SuperFall.gd"

func _enter():
	var next_state = ._enter()
	if host.kind == "Pretty":
		anim_name = "JumpPretty"
	if host.kind == "Ugly":
		anim_name = "JumpUgly"
	return next_state
