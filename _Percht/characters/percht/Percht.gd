extends Fighter

var kind : String = "Pretty"

func change_kind(new_kind):
	kind = new_kind

func _draw():
	._draw()
	var curr_state = current_state()
	
	if not (curr_state.anim_name.ends_with("Pretty") or curr_state.anim_name.ends_with("Ugly")):
		curr_state.anim_name += kind
