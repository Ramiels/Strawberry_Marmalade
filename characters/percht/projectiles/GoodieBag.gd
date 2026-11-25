extends BaseProjectile

var MANDARIN_PROJ = preload("res://_Percht/characters/percht/projectiles/Mandarin.tscn")
var PEANUTS = preload("res://_Percht/characters/percht/projectiles/PeanutsParticles.tscn")
#var dirs = [["2.0", "-4.0", "1.2"], ["2.0", "-2.0", "0.9"], ["5.0", "-1.0", "0.7"]]

var split_amount = 3
var split_distance = "10"
var split_angle = "0.4"

func disable():
	creator.goodie_bag = null
	creator.goodie_bag_die()
	.disable()

func explode():
	"""
	for dir in dirs:
		var obj = spawn_object(MANDARIN_PROJ, 0, 0)
		obj.set_vel(fixed.mul(dir[0], str(get_facing_int())), dir[1])
		
		var extra_force = fixed.mul(str(get_vel().y), dir[2])
		obj.apply_force("0.0", extra_force)
		
		spawn_particle_effect_relative(PEANUTS, Vector2(0, 0))
		
	disable()
	"""
		
	if split_amount > 0:
		for n in split_amount:
			
			
			var dir = fixed.vec_mul(get_vel().x, get_vel().y, "1.5")
			
			
			
			var split_dir = fixed.rotate_vec(dir.x, dir.y, fixed.mul(split_angle, str(n-split_amount/2)))
			if split_amount%2 == 0:
				split_dir = fixed.rotate_vec(split_dir.x, split_dir.y, fixed.mul(split_angle, "0.5"))
			
			var obj = spawn_object(MANDARIN_PROJ, 0, 0, true)
			spawn_particle_effect_relative(PEANUTS, Vector2(0,0))
			
			#obj.reset_momentum()
			obj.set_vel(split_dir.x, split_dir.y)
			
			print("----raw dir----")
			print(dir.x)
			print(dir.y)
			print("----splitdir----")
			print(split_dir.x)
			print(split_dir.y)
	
	disable()
