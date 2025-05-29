extends "res://characters/states/AirDash.gd"

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
	._enter()
	anim_name = "SwagdashAerialPretty"
	host.colliding_with_opponent = false
	
	host.spawn_particle_effect_relative(SmokeDashParticle, Vector2(), Vector2(float(data.x), float(data.y)))
	
	#print("enter: ", anim_name)

func _frame_0():
	host.consume_smoke()
	var next_state = ._frame_0()
	#anim_name = anim_name + host.kind
	anim_name = "SwagdashAerialPretty"
	#print("frame0: ", anim_name)
	return next_state


func _tick():
	._tick()
	host.apply_y_fric(fric)

func _exit():
	host.colliding_with_opponent = true
	host.whip_combo = true
