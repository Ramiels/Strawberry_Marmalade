extends CharacterState

const MIN_AIRDASH_HEIGHT = 10
const BACKDASH_LAG_FRAMES = 4
const Y_MODIFIER = "0.60"
const MIN_IASA = 0
const MAX_IASA = 14
const COMBO_IASA = 7
const MAX_EXTRA_LAG_FRAMES = 5
const NEUTRAL_MIN_IASA = 9
var MOVE_DIST = "100"

export  var dir_x = "3.0"
export  var dir_y = "-5.0"
export  var speed = "2.0"
export  var fric = "0.05"
export  var forward_dash_name = "DashForward"
export  var backward_dash_name = "DashBackward"

var starting_y = 0
var startup_lag_frames = 0

#func _frame_1():
#	spawn_particle_relative(preload("res://fx/DashParticle.tscn"), host.hurtbox_pos_relative_float(), Vector2(data.x, data.y))


var SmokeDashParticle = preload("res://_Percht/characters/percht/SmokeDashEffect.tscn")
var SmokeTeleportParticle = preload("res://_Percht/characters/percht/SmokeVanishEffect.tscn")


func _frame_0():
	host.consume_smoke()

func _frame_4():

	
	var dir = xy_to_dir(data["Teleport"].x, data["Teleport"].y, "1.0", "1.0")
	dir = fixed.normalized_vec_times(dir.x, dir.y, "1")
	dir = fixed.vec_mul(dir.x, dir.y, MOVE_DIST)
	
	host.move_directly(dir.x, dir.y)
	var vel = host.get_vel()

	host.update_data()

func _frame_5():
	
	
	
	var force = xy_to_dir(data["Dash"].x, data["Dash"].y, speed)
	var dir = xy_to_dir(data["Dash"].x, data["Dash"].y)
	starting_y = host.get_pos().y
	var back = false
	if host.combo_count > 0:
		starting_iasa_at = COMBO_IASA
	else :
		starting_iasa_at = Utils.int_max(fixed.round(fixed.add(fixed.mul(fixed.vec_len(dir.x, dir.y), str(MAX_IASA - MIN_IASA)), str(MIN_IASA))), NEUTRAL_MIN_IASA)
	iasa_at = starting_iasa_at
	if "-" in force.x:
		if host.get_facing() == "Right" and data["Dash"].x != 0:
			anim_name = backward_dash_name
			back = true
		else :
			anim_name = forward_dash_name
	else :
		if host.get_facing() == "Left" and data["Dash"].x != 0:
			anim_name = backward_dash_name
			back = true
		else :
			anim_name = forward_dash_name
	if back and host.combo_count <= 0:
		backdash_iasa = true
		beats_backdash = false

		host.hitlag_ticks += BACKDASH_LAG_FRAMES
		host.add_penalty(5)
	else :
		backdash_iasa = false
		beats_backdash = true

	anim_name = "SwagdashAerialUgly"
	
	host.apply_force(force.x, fixed.mul(force.y, Y_MODIFIER) if "-" in force.y else force.y)
	
	host.spawn_particle_effect_relative(SmokeDashParticle, Vector2(0.0, -18.0), Vector2(float(data["Dash"].x), float(data["Dash"].y)))
	host.spawn_particle_effect_relative(SmokeTeleportParticle, Vector2(0.0, -18.0))

func _tick():

	host.apply_x_fric(fric)
	host.apply_forces_no_limit()
	if host.is_grounded():
		if host.combo_count > 0:

			pass
		else :

			var vel = host.get_vel()
			if host.get_opponent_dir() != fixed.sign(vel.x):
				host.set_vel(fixed.mul(vel.x, "0.6"), vel.y)
	
	if current_tick > 4:
		next_state_on_hold_on_opponent_turn = true
	else:
		next_state_on_hold_on_opponent_turn = false

export  var _c_Percht = 0
export (String) var kind
export (bool) var kind_locked = false



func is_usable():
	var correct = true
	if kind != "":
		if host.kind != kind and kind_locked:
			correct = false
	
	var in_smoke = false
	if host.overlapping_smoke() != null or host.smoke_cloak:
		in_smoke = true
	
	return .is_usable() and correct and in_smoke

func _enter():
	._enter()
	anim_name = "SwagdashAerialUgly"
	host.colliding_with_opponent = false
	
	#host.spawn_particle_effect_relative(SmokeDashParticle, Vector2(), Vector2(float(data["Dash"].x), float(data["Dash"].y)))
	
	#print("enter: ", anim_name)

func _exit():
	host.colliding_with_opponent = true
