extends "res://_Percht/PerchtMove.gd"

var is_whip_move = true

var PROJ_SCENE = preload("res://_Percht/characters/percht/projectiles/WhiplashSlash.tscn")

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj.is_in_group("Fighter"):
		var proj = host.spawn_object(PROJ_SCENE, 0, 0, true)

func is_usable():
	var earliest_base = 99999
	for child in get_children():
		if child is Hitbox:
			if child.start_tick < earliest_base:
				earliest_base = child.start_tick
	if host.whip_combo: host.change_action_e_hitbox_frame(get_name(), earliest_base-3)
	else: host.change_action_e_hitbox_frame(get_name(), earliest_base)
	
	return .is_usable()
