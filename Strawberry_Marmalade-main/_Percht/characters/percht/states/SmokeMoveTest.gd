extends "res://Strawberry_Marmalade-main/_Percht/PerchtMove.gd"

var smoke_index = 0

func _enter():
	._enter()
	#print(data.x)
	#print(host.objs_map)
	#print(host.smoke_projectiles)

	if data.x > len(host.smoke_projectiles):
		data.x = len(host.smoke_projectiles)
	
	if data.x >= 0:
		smoke_index = data.x - 1

func _frame_6():
	host.smoke_teleport(smoke_index)

func is_usable():
	return .is_usable() and host.overlapping_smoke() != null
