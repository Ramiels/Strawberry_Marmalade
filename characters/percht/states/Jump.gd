extends "res://characters/states/Jump.gd"

export  var _c_Percht = 0
export (String) var kind
export (bool) var kind_locked = false

func is_usable():
	var correct = true
	if kind != "":
		if host.kind != kind and kind_locked:
			correct = false

	return .is_usable() and correct

func _tick():
	var next_state = ._tick()
	anim_name = anim_name + host.kind
	return next_state
