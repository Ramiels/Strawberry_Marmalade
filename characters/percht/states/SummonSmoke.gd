extends "res://_Percht/PerchtMove.gd"

var PROJ_SCENE = preload("res://_Percht/characters/percht/projectiles/Smoke.tscn")
var number = 6 # must be even
var distance = 55

#func _frame_1():
	#print(host.smoke_projectiles)
	#for smoke in host.smoke_projectiles:
	#	host.objs_map[smoke].smokescreen_disable()

func _frame_6():
	var vec = xy_to_dir(data.x, data.y)
	var dir = fixed.normalized_vec(str(data.x), str(data.y))
	var start_x = fixed.mul(vec.x, str(distance * number/2))
	var start_y = fixed.mul(vec.y, str(distance * number/2))
	start_x = fixed.sub(start_x, fixed.mul(str(distance * number/2), dir.x))
	start_y = fixed.sub(start_y, fixed.mul(str(distance * number/2), dir.y))
	start_y = fixed.sub(start_y, "20")
	
	for i in range(number):
		var move_by = fixed.vec_mul(dir.x, dir.y, str(distance * i))
		var pos = fixed.vec_add(start_x, start_y, move_by.x, move_by.y)
		if int(floor(float(pos.y))) > -20:
			pos.y = -20
		var smoke = host.spawn_object(PROJ_SCENE, int(floor(float(pos.x))), int(floor(float(pos.y))), false)
		host.smoke_projectiles.append(smoke.obj_name)
		smoke.smokescreen = true
