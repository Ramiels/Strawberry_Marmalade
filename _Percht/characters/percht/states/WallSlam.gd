extends "res://characters/states/WallSlam.gd"

func _enter():
	var next_state = ._enter()
	if host.kind == "Pretty":
		anim_name = "WallSlamPretty"
	if host.kind == "Ugly":
		anim_name = "WallSlamUgly"
	return next_state
