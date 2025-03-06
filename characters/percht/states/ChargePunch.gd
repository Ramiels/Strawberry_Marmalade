extends "res://_Percht/PerchtMove.gd"

#class_name GuardAttackState

var opp_hitboxes
var last_state
var opp_start_tick = 0
var prev_hitboxes
var prev_hitbox # new

export var _c_Guard_Data = 0
export var guards_high = true
export var guards_mid = true
export var guards_low = true
export var guards_guard_break = false # figured id put this here for the sake of it
export var guard_start_tick = 0
export var guard_duration = 0

var valid_guard = true


#func _frame_4():
	#host.has_hyper_armor = true
	#host.start_invulnerability()
	
func _enter():
	if data:
		if data.x == 2:
			return "ChargePunch2"
		elif data.x == 3:
			return "ChargePunch3"


func _tick():
	
	if current_tick == guard_start_tick-1: #start guard state
		host.start_invulnerability()
		host.start_projectile_invulnerability()
		host.play_sound("res://sound/common/whiff1.wav")
		host.guardpoint = true
	if current_tick > guard_start_tick+guard_duration-2: #end guard state
		host.end_invulnerability()
		host.end_projectile_invulnerability()
		host.guardpoint = false
	
	
	opp_hitboxes = get_hitboxes_inactive()
	
	for hitbox in opp_hitboxes:
		#if !hitbox.guard_break and ((guards_high and hitbox.hit_height == 0) or (guards_mid and hitbox.hit_height == 1) or (guards_low and hitbox.hit_height == 2)):
		#	valid_guard = true
		
		# you can pick which height this move guards against at the bottom of the inspector
		valid_guard = (guards_guard_break or !hitbox.guard_break) and ((guards_high and hitbox.hit_height == 0) or (guards_mid and hitbox.hit_height == 1) or (guards_low and hitbox.hit_height == 2))
		
		if !valid_guard:
			host.end_invulnerability()
		
		if hitbox.active and hitbox.overlaps(host.hurtbox) and valid_guard and not host.name in hitbox.hit_objects:
			host.play_sound("Block2")
			host.play_sound("Block3")
			host.global_hitlag(6)
			host.screen_bump()
			var chip = fixed.round(fixed.mul(str(hitbox.damage / 3), hitbox.chip_damage_modifier))
			host.take_damage(chip, 0, "0.6", 0, "2.0")
			hitbox.save_hit_object(host)
			
			host.spawn_particle_effect(preload("res://fx/FlawedParryEffect.tscn"), Vector2(host.data.object_data.position_x+10, host.data.object_data.position_y-30) + Vector2(host.get_facing_int(), 0))
			return
		
	
	opp_hitboxes = get_hitboxes() #i cant be bothered to implement a toggle for projectile guarding
	for hitbox in opp_hitboxes:
		if hitbox.active and hitbox.overlaps(host.hurtbox) and not host.name in hitbox.hit_objects and not hitbox is ThrowBox: #and hitbox != prev_hitbox:
			host.play_sound("Block2")
			host.play_sound("Block3")
			host.global_hitlag(6)
			host.screen_bump()
			var chip = fixed.round(fixed.mul(str(hitbox.damage / 3), hitbox.chip_damage_modifier))
			print(chip, " ", hitbox.damage)
			host.take_damage(chip, 0, "0.6", 0, "2.0")
			hitbox.save_hit_object(host)
			#prev_hitbox = hitbox
			host.spawn_particle_effect(preload("res://fx/FlawedParryEffect.tscn"), Vector2(host.data.object_data.position_x+10, host.data.object_data.position_y-30) + Vector2(host.get_facing_int(), 0))
			return
	
func _exit():
	host.guardpoint = false

func get_hitboxes_inactive():
	var all_hitbox_nodes = []
	for child in host.opponent.current_state().get_children():
		if child is Hitbox and not child is ThrowBox:
			all_hitbox_nodes.append(child)
			
	return all_hitbox_nodes


func get_hitboxes(): #this one also looks up projectile hitboxes, thanks to discord user xColdxFusionx
	
	var opp_hitboxes = []
	for obj_key in host.opponent.objs_map:
		var new_object = host.opponent.objs_map[obj_key]
		if is_instance_valid(new_object):
			if new_object.get_opponent() == host:
				opp_hitboxes.append_array(host.opponent.objs_map[obj_key].get_active_hitboxes())
	return opp_hitboxes
