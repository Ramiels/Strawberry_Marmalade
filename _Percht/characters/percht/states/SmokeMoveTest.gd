extends "res://_Percht/PerchtMove.gd"

func is_usable():
	return .is_usable() and host.overlapping_smoke() != null
