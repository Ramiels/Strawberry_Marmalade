extends "res://characters/states/ThrowTech.gd"

func _enter():
	var next_state = ._enter()
	if host.kind == "Pretty":
		anim_name = "ThrowTechPretty"
	if host.kind == "Ugly":
		anim_name = "ThrowTechUgly"
	return next_state
