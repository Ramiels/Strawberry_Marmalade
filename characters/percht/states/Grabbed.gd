extends "res://characters/states/Grabbed.gd"

func _enter():
	var next_state = ._enter()
	if host.kind == "Pretty":
		anim_name = "GrabbedPretty"
	if host.kind == "Ugly":
		anim_name = "GrabbedUgly"
	return next_state
