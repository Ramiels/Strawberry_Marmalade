extends "res://characters/states/Landing.gd"

func _enter():
	var next_state = ._enter()
	if host.kind == "Pretty":
		anim_name = "LandingPretty"
	if host.kind == "Ugly":
		anim_name = "LandingUgly"
	return next_state
