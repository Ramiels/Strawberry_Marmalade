extends ThrowState

var keep_quickswap = true

func _tick():
	if current_tick >= 4:
		host.apply_force("0.0", "0.1")
	
	if host.is_grounded():
		return "RestandGrabAirThrow"
