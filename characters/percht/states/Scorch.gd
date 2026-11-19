extends "res://_Percht/PerchtMove.gd"

var torched_objs: Array = []

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
							if obj_name != torched_name and !obj.get_scheduled_explode():
								
								obj.explode()
								torched_objs.append(obj_name)
					else:
						obj.explode()
						torched_objs.append(obj_name)
					break
	

func _tick():
	smoke_explosion()

func _exit():
	torched_objs.clear()
