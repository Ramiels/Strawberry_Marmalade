extends "res://characters/states/OffensiveBurst.gd"

func _enter():
	var next_state = ._enter()
	if host.kind == "Pretty":
		anim_name = "BurstPretty"
	if host.kind == "Ugly":
		anim_name = "BurstPretty"
	return next_state
