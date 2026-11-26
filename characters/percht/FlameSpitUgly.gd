extends "res://_Percht/PerchtMove.gd"

var torched_objs: Array = []

#var times_flame_hit = 0
#var hitcancel_theshold = 1

var flame_has_hit = false
var ticks_since_hit = 0

onready var flame_spit_particle = $"%FlameSpitParticle"

func _enter():
	for child in host.current_state().get_children():
		if child is Hitbox:
			child.activated = true
	iasa_on_hit = -1
	flame_has_hit = false
	ticks_since_hit = 0
	
	if data:
		print(data.y)
		if data.y == -1:
			flame_spit_particle.position.x = 50
			flame_spit_particle.position.y = -70
			flame_spit_particle.rotation_degrees = -45
			return "FlameHighUgly"
		elif data.y == 1:
			flame_spit_particle.position.x = 45
			flame_spit_particle.position.y = 20
			flame_spit_particle.rotation_degrees = 45
			return "FlameLowUgly"
		else:
			flame_spit_particle.position.x = 70
			flame_spit_particle.position.y = -20
			flame_spit_particle.rotation_degrees = 0
			return "FlameMidUgly"

func smoke_explosion():
	var hitboxes = get_active_hitboxes()
	
	for hitbox in hitboxes:
		for obj_name in host.objs_map:
			var obj = host.objs_map[obj_name]
			if obj and not obj.disabled and obj.id == host.id and hitbox.overlaps(obj.collision_box) and obj != Hitbox:
				#print('overlapping', obj)
				if "percht_smoke" in obj:
					if torched_objs:
						for torched_name in torched_objs:
							if not obj_name in torched_objs:
								
								obj.explode()
								torched_objs.append(obj_name)
					else:
						obj.explode()
						torched_objs.append(obj_name)
					break
	

func _on_hit_something(obj, hitbox):
	#times_flame_hit += 1
	flame_has_hit = true
	ticks_since_hit = 0
	
	._on_hit_something(obj, hitbox)

func _tick():
	smoke_explosion()
	
	ticks_since_hit += 1
	if ticks_since_hit > 3 and flame_has_hit:
		iasa_on_hit = current_tick + 1
	
	"""
	if current_tick == 1:
		for child in host.current_state().get_children():
			if child is Hitbox:
				child.cancellable = false
	
	
	if times_flame_hit >= hitcancel_theshold:
		for child in host.current_state().get_children():
			if child is Hitbox:
				child.cancellable = true
	"""
	

func _frame_6():
	flame_spit_particle.start_emitting()

func _frame_26():
	#timed_particle_scene
	flame_spit_particle.stop_emitting()
	for child in host.current_state().get_children():
		if child is Hitbox:
			child.activated = false

func _exit():
	torched_objs.clear()
	flame_spit_particle.stop_emitting()
	#times_flame_hit = 0
