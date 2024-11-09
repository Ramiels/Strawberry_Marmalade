extends "res://_Percht/PerchtMove.gd"

export var off_ground_frame = -1

func _enter():
	if data:
		if host.is_grounded():
			if data.y == -1:
				return "RestandGrabAirU"
			if data.y == 0:
				return "RestandGrabGroundF"
			if data.y == 1:
				return "RestandGrabGroundD"
		else:
			if data.y == -1:
				return "RestandGrabAirU"
			if data.y == 0:
				return "RestandGrabAirF"
			if data.y == 1:
				return "RestandGrabAirD"

func _tick():
	if off_ground_frame > 0:
		if current_tick + 1 == off_ground_frame:
			host.set_grounded(false)
