extends ThrowState

var keep_quickswap = true

func _tick():
	if host.is_grounded():
		return "RestandGrabAirThrow"
