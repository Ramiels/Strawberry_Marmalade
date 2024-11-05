extends BaseProjectile

var MANDARIN_PROJ = preload("res://_Percht/characters/percht/projectiles/Mandarin.tscn")
var PEANUTS = preload("res://_Percht/characters/percht/projectiles/PeanutsParticles.tscn")
var dirs = [["2.0", "-4.0"], ["2.0", "-2.0"], ["5.0", "-1.0"]]

func disable():
	creator.goodie_bag = null
	.disable()

func explode():
	for dir in dirs:
		var obj = spawn_object(MANDARIN_PROJ, 0, 0)
		obj.set_vel(dir[0], dir[1])
		spawn_particle_effect_relative(PEANUTS, Vector2(0, 0))

		
		disable()
