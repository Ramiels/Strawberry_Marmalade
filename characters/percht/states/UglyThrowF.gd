extends ThrowState

func _enter():
	if host.combo_count > 0:
		hitstun_ticks = 29
		wall_slam = false
	else:
		hitstun_ticks = 48
		wall_slam = true
