extends "res://characters/states/AirDash.gd"

func _enter():
	._enter()
	anim_name = "Fall" + host.kind
	
	#print("enter: ", anim_name)

func _frame_0():
	var next_state = ._frame_0()
	anim_name = anim_name + host.kind
	#print("frame0: ", anim_name)
	return next_state
