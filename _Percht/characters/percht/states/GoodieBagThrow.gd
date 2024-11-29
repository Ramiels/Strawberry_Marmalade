extends "res://_Percht/PerchtMove.gd"

var PROJ_SCENE = preload("res://_Percht/characters/percht/projectiles/GoodieBag.tscn")

const SPEED = "10"
var grounded = false

func _enter():
	grounded = host.is_grounded()

func _frame_6():
	var pos_y = -15
	if !grounded:
		pos_y = 10
	
	var obj = host.spawn_object(PROJ_SCENE, 20, pos_y, true)

	var force = xy_to_dir(data.x, data.y, SPEED)
	force.x = fixed.mul(force.x, str(host.get_facing_int()))
	obj.set_grounded(false)
	obj.apply_force_relative(force.x, force.y)
	obj.apply_force(host.get_vel().x, "0")
	var vel_y = 0
	if fixed.lt(host.get_vel().y, "0"):
		vel_y = host.get_vel().y
	else:
		vel_y = "0"
	obj.apply_force("0", vel_y)
	
	host.goodie_bag = obj.obj_name

func is_usable():
	return (.is_usable() and host.goodie_bag == null and host.goodie_bag_delay == 0)
