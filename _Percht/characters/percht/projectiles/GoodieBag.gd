extends BaseProjectile

var MANDARIN_PROJ = preload("res://_Percht/characters/percht/projectiles/Mandarin.tscn")
var PEANUTS = preload("res://_Percht/characters/percht/projectiles/PeanutsParticles.tscn")
var dirs = [["2.0", "-4.0", "1.2"], ["2.0", "-2.0", "0.9"], ["5.0", "-1.0", "0.7"]]

func disable():
	creator.goodie_bag = null
	.disable()

func explode():
	for dir in dirs:
		var obj = spawn_object(MANDARIN_PROJ, 0, 0)
		obj.set_vel(fixed.mul(dir[0], str(get_facing_int())), dir[1])
		
		var extra_force = fixed.mul(str(get_vel().y), dir[2])
		obj.apply_force("0.0", extra_force)
		
		spawn_particle_effect_relative(PEANUTS, Vector2(0, 0))
		
		disable()
