extends "res://_Percht/PerchtMove.gd"

func smoke_explosion():
	var hitboxes = get_active_hitboxes()
	
	for hitbox in hitboxes:
		for obj_name in host.objs_map:
			var obj = host.objs_map[obj_name]
			if obj and not obj.disabled and obj.id == host.id and hitbox.overlaps(obj.collision_box) and obj != Hitbox:
				#print('overlapping', obj)
				if "percht_smoke" in obj:
					obj.explode()
	

func _tick():
	smoke_explosion()
