extends "res://characters/states/Grab.gd"

func _enter():
	var next_state = ._enter()
	if host.kind == "Pretty":
		anim_name = "GrabPretty"
	if host.kind == "Ugly":
		anim_name = "GrabUgly"
	return next_state
