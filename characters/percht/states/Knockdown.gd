extends "res://characters/states/Knockdown.gd"

func _enter():
	var next_state = ._enter()
	if host.kind == "Pretty":
		anim_name = "KnockdownPretty"
	if host.kind == "Ugly":
		anim_name = "KnockdownUgly"
	return next_state
