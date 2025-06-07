extends CharacterState

const MIN_IASA = 7
const MIN_NEUTRAL_IASA = 9
const MAX_IASA = 14
const MIN_SPEED_RATIO = "0.5"
var MAX_SPEED_RATIO = "1.25"
var MOVE_DIST = "70"

export  var dir_x = 1
export  var dash_speed = 100
export  var dash_speed_string = "0"
export  var fric = "0.05"
export  var spawn_particle = true
export  var startup_lag = 0
export  var stop_frame = 0
export  var back_penalty = 5
export  var air = false

export  var speed_limit = "40"
var updated = false
var charged = false
var auto = false
var dash_force = "0"

var dist_ratio = "1.0"


var SmokeDashParticle = preload("res://_Percht/characters/percht/SmokeDashEffect.tscn")
var SmokeTeleportParticle = preload("res://_Percht/characters/percht/SmokeVanishEffect.tscn")


func get_velocity_forward_meter_gain_multiplier():
	return fixed.mul(velocity_forward_meter_gain_multiplier, dist_ratio)

func _frame_0():
	host.consume_smoke()

func _frame_4():
	
	if data["Teleport"].x == 0 || data["Teleport"].y == 0:
		#MOVE_DIST = fixed.round(fixed.mul("1,414", MOVE_DIST))
		MOVE_DIST = "100"
	
	var dir = xy_to_dir(data["Teleport"].x, data["Teleport"].y, MOVE_DIST, "1.0")

	host.move_directly(dir.x, dir.y)
	var vel = host.get_vel()

	host.update_data()

func _frame_5():

	MAX_SPEED_RATIO = "1.25"
	beats_backdash = true
	dist_ratio = fixed.add(fixed.div(str(data["Dash"].x), "100"), "0.0")
	var min_iasa = MIN_IASA if host.combo_count > 0 else MIN_NEUTRAL_IASA

	if not charged and host.combo_count > 0:
		starting_iasa_at = min_iasa
	else :
		starting_iasa_at = Utils.int_max(fixed.round(fixed.add(fixed.mul(dist_ratio, str(MAX_IASA - min_iasa)), str(min_iasa))), 1)

	iasa_at = starting_iasa_at
	
	if startup_lag != 0:
		return 
	var dash_force = str(dir_x * dash_speed) if dash_speed_string == "0" else fixed.mul(str(dir_x), dash_speed_string)

	host.apply_force_relative(fixed.mul(dash_force, fixed.add(fixed.mul(dist_ratio, fixed.sub(MAX_SPEED_RATIO, MIN_SPEED_RATIO)), MIN_SPEED_RATIO)), "0")
	if spawn_particle:
		spawn_particle_relative(preload("res://fx/DashParticle.tscn"), host.hurtbox_pos_relative_float(), Vector2(dir_x, 0))
	if not air:
		host.apply_grav()
		
	host.spawn_particle_effect_relative(SmokeDashParticle, Vector2(0.0, -18.0), Vector2(host.get_facing_int(), 0))
	host.spawn_particle_effect_relative(SmokeTeleportParticle, Vector2(0.0, -18.0))

func spawn_dash_particle():
	spawn_particle_relative(preload("res://fx/DashParticle.tscn"), host.hurtbox_pos_relative_float(), Vector2(dir_x, 0))

func _tick():
	host.apply_x_fric(fric)
	if not air:
		host.apply_grav()
	host.apply_forces_no_limit()
	
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
	host.colliding_with_opponent = false
	
	#host.spawn_particle_effect_relative(SmokeDashParticle, Vector2(0.0, -18.0), Vector2(float(data["Teleport"].x), float(data["Teleport"].y)))
	
	#print("enter: ", anim_name)

func _exit():
	host.colliding_with_opponent = true
