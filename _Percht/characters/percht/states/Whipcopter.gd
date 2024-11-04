extends "res://_Percht/PerchtMove.gd"

var SPEED = "7"
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
	
	host.set_vel(fixed.mul(host.get_vel().x, "0.7"), fixed.mul(host.get_vel().y, "0.5"))

func _frame_6():
	if host.is_grounded():
		host.set_grounded(false)
		host.apply_force_relative("0", LIFT_FORCE)

func _frame_7():
	var speed = fixed.sub(SPEED, fixed.div(str(data["Length"].x), "1.2"))
	
	var force = xy_to_dir(data["Direction"].x, data["Direction"].y, speed)
	force.x = fixed.mul(force.x, str(host.get_facing_int()))
	
	host.apply_force_relative(force.x, force.y)

func _tick_before():
	if current_tick >= 7:
		if current_tick >= 10 and whipcopter_repeats > 1:
			current_tick = 6
			
			whipcopter_repeats -= 1
			
			if whipcopter_repeats == 1:
				hitbox.cancellable = true
				hitbox2.cancellable = true

func _frame_12():
	apply_fric = true
