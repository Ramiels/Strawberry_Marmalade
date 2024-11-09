extends "res://characters/states/RollStartup.gd"

func _enter():
	var next_state = ._enter()
	anim_name += host.kind
	return next_state
