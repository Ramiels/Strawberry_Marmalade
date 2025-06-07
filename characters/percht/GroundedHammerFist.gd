extends "res://_Percht/PerchtMove.gd"

func _enter():
	if data:
		if data.x * host.get_facing_int() == -1:
			return "GroundedHammerFistBackward"
