extends "res://_Percht/PerchtMove.gd"

var WHISP_SCENE = preload("res://_Percht/characters/percht/projectiles/Wisp.tscn")

var x_mult = "5"
var y_mult = "5"

func _ready():
	pass

func _frame_5():
	
	if data:
		var wisp = host.spawn_object(WHISP_SCENE, 40, -30, true)
		wisp.set_data(str(data.x * host.get_facing_int()), str(data.y), x_mult, y_mult)
		host.wisp_projectiles.append(wisp.obj_name)
