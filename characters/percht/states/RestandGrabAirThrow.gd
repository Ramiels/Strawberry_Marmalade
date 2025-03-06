extends ThrowState

func _enter():
	if host.restand_grab_used:
		minimum_grounded_frames = 1
	else:
		minimum_grounded_frames = 22
	
	if state_name == "RestandGrabGroundThrow":
		if host.restand_grab_used:
			hitstun_ticks = 11
			air_ground_bounce = true
			knockdown = false
		else:
			hitstun_ticks = 22
			air_ground_bounce = false
			knockdown = true
	
	host.restand_grab_used = true
