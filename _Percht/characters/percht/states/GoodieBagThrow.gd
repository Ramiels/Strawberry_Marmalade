extends "res://_Percht/PerchtMove.gd"

var PROJ_SCENE = preload("res://_Percht/characters/percht/projectiles/GoodieBag.tscn")

const SPEED = "9"

func _frame_6():
	var pos_y = -15
	if !host.is_grounded():
		pos_y = 15
	
	var obj = host.spawn_object(PROJ_SCENE, 20, pos_y, true)

	var force = xy_to_dir(data.x, data.y, SPEED)
	force.x = fixed.mul(force.x, str(host.get_facing_int()))
	obj.set_grounded(false)
	obj.apply_force_relative(force.x, force.y)
	obj.apply_force(host.get_vel().x, host.get_vel().y)
	
	host.goodie_bag = obj.obj_name

func is_usable():
	return (.is_usable() and host.goodie_bag == null)
