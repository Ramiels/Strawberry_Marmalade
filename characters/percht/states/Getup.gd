extends "res://characters/states/Getup.gd"

func _enter():
	var next_state = ._enter()
	if host.kind == "Pretty":
		anim_name = "GetupPretty"
	if host.kind == "Ugly":
		anim_name = "GetupUgly"
	return next_state
