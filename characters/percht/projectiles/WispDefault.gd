extends DefaultFireball

func _ready():
	pass
	
func _enter():
	pass

func _tick():
	._tick()
	smoke_explosion()
	if current_tick % 20 == 0:
		host.play_sound("Fire")
	pass

func smoke_explosion():
	
	var hitboxes = get_active_hitboxes()
	
	for hitbox in hitboxes:
		check_burn_contact(hitbox)
	
	var collisionbox = $"../../CollisionBox"
	check_burn_contact(collisionbox)
	

func check_burn_contact(burnbox):
	for obj_name in host.objs_map:
		var obj = host.objs_map[obj_name]
		if obj and not obj.disabled and obj.id == host.id and burnbox.overlaps(obj.collision_box) and obj != Hitbox:
			#print('overlapping', obj)
			if "percht_smoke" in obj:
				if host.torched_objs:
					for torched_name in host.torched_objs:
						if not obj_name in host.torched_objs:
							obj.explode()
							host.torched_objs.append(obj_name)
				else:
					obj.explode()
					host.torched_objs.append(obj_name)
				break

func on_got_blocked():
	.on_got_blocked()
