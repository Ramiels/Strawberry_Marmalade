extends "res://Strawberry_Marmalade-main/_Percht/PerchtMove.gd"

var PROJ_SCENE = preload("res://Strawberry_Marmalade-main/_Percht/characters/percht/projectiles/Smoke.tscn")

#func _frame_1():
#	for smoke in host.smoke_projectiles:
#		host.objs_map[smoke].disable()

const SPEED = "10"

func _frame_7():
	var smoke = host.spawn_object(PROJ_SCENE, 20, -20, true)

	var force = xy_to_dir(data.x, data.y, SPEED)
	force.x = fixed.mul(force.x, str(host.get_facing_int()))
	smoke.set_grounded(false)
	smoke.apply_force_relative(force.x, force.y)
	#print(data)
	
	host.smoke_projectiles.append(smoke.obj_name)
