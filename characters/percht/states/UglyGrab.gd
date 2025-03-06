extends "res://characters/states/Grab.gd"

func is_usable():
	return .is_usable() and host.kind == "Ugly"
