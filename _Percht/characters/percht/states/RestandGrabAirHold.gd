extends ThrowState

func _tick():
	if host.is_grounded():
		return "RestandGrabAirThrow"
