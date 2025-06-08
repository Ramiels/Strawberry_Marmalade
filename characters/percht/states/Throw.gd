extends "res://characters/states/ThrowState.gd"

func _frame_0():
	host.whip_combo = true
	
	if host.combo_count > 0:
		minimum_grounded_frames = 4
	else:
		minimum_grounded_frames = 15
