extends "res://_Percht/PerchtMove.gd"

#var PROJ_SCENE = preload("res://_Percht/characters/percht/projectiles/NewSmoke.tscn")
var WHISP_SCENE = preload("res://_Percht/characters/percht/projectiles/Wisp.tscn")

var x_mult = "5"
var y_mult = "5"

var number = 4 # must be even

#func _frame_1():
	#print(host.smoke_projectiles)
	#for smoke in host.smoke_projectiles:
	#	host.objs_map[smoke].smokescreen_disable()

func _frame_6():
	var vec_start = Utils.fixed_vec2_string(str(data["Start"].x * host.get_facing_int()), str(data["Start"].y))
	var vec_end = Utils.fixed_vec2_string(str(data["End"].x * host.get_facing_int()), str(data["End"].y))
	var delta = fixed.vec_sub(vec_end.x, vec_end.y, vec_start.x, vec_start.y)
	
	for i in range(number):
		var mult = fixed.div(str(i), str(number - 1))
		var new_target = fixed.vec_add(vec_start.x, vec_start.y, fixed.mul(delta.x, mult), fixed.mul(delta.y, mult))
		
		var wisp = host.spawn_object(WHISP_SCENE, 40, -30, true)
		wisp.set_data(new_target.x, new_target.y, x_mult, y_mult)
		host.wisp_projectiles.append(wisp.obj_name)
