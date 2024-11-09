extends "res://characters/states/Dash.gd"

func _enter():
	var next_state = ._enter()
	if host.kind == "Pretty":
		anim_name = "DashForwardPretty"
	if host.kind == "Ugly":
		anim_name = "DashForwardUgly"
	return next_state
