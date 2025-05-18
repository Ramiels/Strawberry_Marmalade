extends "res://characters/states/Dash.gd"

export  var _c_Percht = 0
export (String) var kind
export (bool) var kind_locked = false

func is_usable():
	var correct = true
	if kind != "":
		if host.kind != kind and kind_locked:
			correct = false

	return .is_usable() and correct

func _enter():
	var next_state = ._enter()
	if host.kind == "Pretty":
		anim_name = "DashForwardPretty"
	if host.kind == "Ugly":
		anim_name = "DashForwardUgly"
	return next_state
