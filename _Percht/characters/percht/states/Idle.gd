extends "res://_Percht/PerchtMove.gd"

export  var auto_fall = true

func _enter():
	if auto_fall:
		if not host.is_grounded():
			return "Fall"

func _tick():
	host.apply_fric()
	host.apply_forces()

	if auto_fall:
		if not host.is_grounded():
			return "Fall"
	if host.hp <= 0:
		return "Knockdown"
