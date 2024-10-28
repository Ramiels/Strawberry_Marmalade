extends Fighter

var kind : String = "Pretty"
var smoke_projectiles = []

func change_kind(new_kind):
	kind = new_kind
	#if kind == "Ugly":
		# Placeholder
		#default_hurtbox.width = 20
	#else:
		# Placeholder
		#default_hurtbox.width = 14

func _draw():
	var curr_state = current_state()
	var anim_name = curr_state.anim_name

	
	# This is ATROCIOUS.
	if not anim_name.ends_with("BOTH"):
		if anim_name.ends_with("Pretty"):
			anim_name.erase(anim_name.length() - 6, 6)
		if anim_name.ends_with("Ugly"):
			anim_name.erase(anim_name.length() - 4, 4)
		
		anim_name += kind
	
	curr_state.anim_name = anim_name
	
	#if not is_ghost:
	#	print("_draw() ", kind)
	#	print(curr_state, curr_state.anim_name)
	
	._draw()

func overlapping_smoke():
	var overlapped_smoke = null
	for obj_name in objs_map:
		var obj = objs_map[obj_name]
		if obj and not obj.disabled and obj.id == id and hurtbox.overlaps(obj.hurtbox) and obj != Hitbox:
			#print('overlapping', obj)
			if "percht_smoke" in obj:
				overlapped_smoke = obj
				#print('overlapped_smoke')

	return overlapped_smoke

func tick():
	.tick()
	if !is_ghost:
		overlapping_smoke()

func smoke_teleport(smoke_index):
	var smoke_obj = objs_map[smoke_projectiles[smoke_index]]
	var smoke_pos = smoke_obj.get_pos()
	
	print(smoke_pos.y)
	if smoke_pos.y < 0:
		set_grounded(false)
	
	set_pos(smoke_pos.x, smoke_pos.y)
