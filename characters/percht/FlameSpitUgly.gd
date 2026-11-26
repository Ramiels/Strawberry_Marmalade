extends "res://_Percht/PerchtMove.gd"

var torched_objs: Array = []

var times_flame_hit = 0
var hitcancel_theshold = 1

func _enter():
	if data:
		print(data.y)
		if data.y == -1:
			return "FlameHighUgly"
		elif data.y == 1:
			return "FlameLowUgly"
		else:
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
	times_flame_hit += 1
	print(times_flame_hit)
	._on_hit_something(obj, hitbox)

func _tick():
	smoke_explosion()
	
	if current_tick == 1:
		for child in host.current_state().get_children():
			if child is Hitbox:
				child.cancellable = false
	
	
	if times_flame_hit >= hitcancel_theshold:
		for child in host.current_state().get_children():
			if child is Hitbox:
				child.cancellable = true
	
	

func _exit():
	torched_objs.clear()
	times_flame_hit = 0
