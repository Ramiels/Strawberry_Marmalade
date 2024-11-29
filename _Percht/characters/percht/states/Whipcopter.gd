extends "res://_Percht/PerchtMove.gd"

var SPEED = "5"
var Y_VEL_MOD = "0.5"
var LIFT_FORCE = "-6"
var whipcopter_repeats = 0

var is_whip_move = true

onready var hitbox = $Hitbox
onready var hitbox2 = $Hitbox2

func _enter():
	whipcopter_repeats = data["Length"].x
	apply_fric = false
	
	hitbox.cancellable = false
	hitbox2.cancellable = false
	
	#host.set_vel(fixed.mul(host.get_vel().x, "0.7"), fixed.mul(host.get_vel().y, "0.5"))

func _frame_9():
	if host.is_grounded():
		host.set_grounded(false)
		host.apply_force_relative("0", LIFT_FORCE)

func _frame_10():
	var speed = SPEED
	
	var force = xy_to_dir(data["Direction"].x, data["Direction"].y, speed)
	force.x = fixed.mul(force.x, str(host.get_facing_int()))
	force.y = fixed.mul(force.y, Y_VEL_MOD)
	
	host.apply_force_relative(force.x, force.y)

func _tick_before():
	if current_tick >= 10:
		if current_tick >= 13 and whipcopter_repeats > 1:
			current_tick = 9
			
			whipcopter_repeats -= 1
			
			if whipcopter_repeats == 1:
				hitbox.cancellable = true
				hitbox2.cancellable = true

func _frame_13():
	apply_fric = true
