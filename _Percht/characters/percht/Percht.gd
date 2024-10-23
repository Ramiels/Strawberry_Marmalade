extends Fighter

var kind : String = "Pretty"

func change_kind(new_kind):
	kind = new_kind

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
