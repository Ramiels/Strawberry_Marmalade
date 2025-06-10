extends "res://characters/states/Dash.gd"

export  var _c_Percht = 0
export (String) var kind
export (bool) var kind_locked = false

var SmokeDashParticle = preload("res://_Percht/characters/percht/SmokeDashEffect.tscn")

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
	var next_state = ._enter()
	if host.kind == "Pretty":
		anim_name = "SwagdashGroundedPretty"
	if host.kind == "Ugly":
		anim_name = "DashForwardUgly"
	
	host.spawn_particle_effect_relative(SmokeDashParticle, Vector2(0.0, -18.0), Vector2(host.get_facing_int(), 0))
	return next_state

func _frame_0():
	host.consume_smoke()
	._frame_0()
	host.colliding_with_opponent = false

func _tick():
	host.apply_x_fric(fric)
	
	host.limit_speed(speed_limit)
	var repeated = _previous_state() and _previous_state_name() == name
	if (startup_lag > 0 and current_tick == startup_lag) and not repeated:
		host.apply_force_relative(dash_force, "0")
		if spawn_particle:
			spawn_particle_relative(preload("res://fx/DashParticle.tscn"), host.hurtbox_pos_relative_float(), Vector2(dir_x, 0))




	if auto and dir_x > 0 and host.opponent.colliding_with_opponent and not host.opponent.is_in_hurt_state() and current_tick % 4 == 0:
		host.update_data()
		var vel = host.get_vel()
		if not fixed.eq(vel.x, "0") and fixed.sign(vel.x) != host.get_opponent_dir():
			host.update_facing()
			updated = true
			host.set_vel(fixed.mul(fixed.abs(vel.x), str(host.get_opponent_dir())), vel.y)

func _exit():
	host.colliding_with_opponent = true
	host.whip_combo = true
