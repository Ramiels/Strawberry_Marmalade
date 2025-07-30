extends "res://_Percht/PerchtMove.gd"

var PROJ_SCENE = preload("res://_Percht/characters/percht/projectiles/Smoke.tscn")
var number = 4 # must be even
var distance = 55
var force_mult = "5"

#func _frame_1():
	#print(host.smoke_projectiles)
	#for smoke in host.smoke_projectiles:
	#	host.objs_map[smoke].smokescreen_disable()

func _frame_6():
	var vec_start = xy_to_dir(data["Start"].x, data["Start"].y)
	var vec_end = xy_to_dir(data["End"].x, data["End"].y)
	var delta = fixed.vec_sub(vec_end.x, vec_end.y, vec_start.x, vec_start.y)
	
	for i in range(number):
		var mult = fixed.div(str(i), str(number - 1))
		var new_target = fixed.vec_add(vec_start.x, vec_start.y, fixed.mul(delta.x, mult), fixed.mul(delta.y, mult))
		var force = fixed.vec_mul(new_target.x, new_target.y, force_mult)
		
		var smoke = host.spawn_object(PROJ_SCENE, 20, -20, true)
		smoke.apply_force(force.x, force.y)
		smoke.set_grounded(false)
		host.smoke_projectiles.append(smoke.obj_name)
