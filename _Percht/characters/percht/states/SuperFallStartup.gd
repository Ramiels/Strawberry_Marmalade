extends "res://characters/states/SuperFallStartup.gd"

func _enter():
	var next_state = ._enter()
	if host.kind == "Pretty":
		anim_name = "InstantCancelPretty"
	if host.kind == "Ugly":
		anim_name = "InstantCancelUgly"
	return next_state
