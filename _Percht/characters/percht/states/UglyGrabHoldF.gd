extends ThrowState

var from_air = false

func _frame_0():
	if !host.is_grounded():
		from_air = true
		host.set_vel(host.get_vel().x, "-0.5")

func _tick():
	if current_tick > 2 and host.is_grounded():
		if from_air:
			spawn_particle_relative(particle_scene)
		return "UglyThrowF"
