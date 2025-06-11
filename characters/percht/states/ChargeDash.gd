extends "res://characters/states/ChargeDash.gd"

export  var _c_Percht = 0
export (String) var kind
export (bool) var kind_locked = false

func is_usable():
	var correct = true
	if kind != "":
		if host.kind != kind and kind_locked:
			correct = false

	return .is_usable() and correct

func _frame_6():
	if fallback_state == "ChargeDashForward" or fallback_state == "ChargeDashForwardUgly":
		queue_state_change(fallback_state, {"x":100, "charged":true})
	else :
		queue_state_change(fallback_state)

func _enter():
	var next_state = ._enter()
	if host.kind == "Pretty":
		anim_name = "InstantCancelPretty"
	if host.kind == "Ugly":
		anim_name = "InstantCancelUgly"
	return next_state
