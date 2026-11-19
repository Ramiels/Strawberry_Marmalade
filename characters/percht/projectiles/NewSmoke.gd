extends BaseProjectile

var percht_smoke = true
var smokescreen = false
var scheduled_disable = false
var scheduled_explode = false
var scheduled_explode_tick = 0
var exploded = false

var EXPLOSION = preload("res://_Percht/characters/percht/projectiles/NewSmokeExplosion.tscn")

var SMOKEVANISHEFFECT = preload("res://_Percht/characters/percht/SmokeVanishEffect.tscn")
var FLAMEVANISHEFFECT = preload("res://_Percht/characters/percht/FlameVanishEffect.tscn")

func copy_to(f):
	.copy_to(f)
	f.scheduled_disable = scheduled_disable

func disable():
	if exploded: spawn_particle_effect_relative(FLAMEVANISHEFFECT, Vector2())
	else: spawn_particle_effect_relative(SMOKEVANISHEFFECT, Vector2())
	
	$Flip/Particles/ParticleEffect.queue_free()
	$Flip/Particles/FlameParticleEffect.queue_free()
	.disable()
	#creator.smoke_projectiles.erase(obj_name)

func schedule_disable():
	scheduled_disable = true

func smokescreen_disable():
	#print(smokescreen)
	if smokescreen:
		schedule_disable()

func tick():
	.tick()
	
	var id = "?"
	if creator and name in creator.smoke_projectiles:
		id = str(creator.smoke_projectiles.find(name) + 1)
	
	$IndicatorDraw/ID.text = id
	
	var life_left = current_state().lifetime - current_state().current_tick
	$IndicatorDraw/Lifetime.text = str(life_left)
	
	if scheduled_disable:
		disable()
	if scheduled_explode and !exploded:
		if scheduled_explode_tick == 0:
			explode()
		scheduled_explode_tick -= 1
	
	#check_explode()
	

func schedule_explode():
	scheduled_explode = true
	scheduled_explode_tick = 2

func explode():
	$Flip/Particles/ParticleEffect.stop_emitting()
	$Flip/Particles/FlameParticleEffect.start()
	#disable()
	
	spawn_object(EXPLOSION, 0, 0)
	
	change_state("Burning")
	
	if exploded: current_state().lifetime -= 100
	
	exploded = true
	
	
	
	for obj_name in objs_map:
		var obj = objs_map[obj_name]
		if obj and not obj.disabled and obj.id == id and collision_box.overlaps(obj.collision_box) and obj != Hitbox and obj != self:
			#print('overlapping', obj)
			if "percht_smoke" in obj:
				obj.schedule_explode()
	

func check_explode(): # makes smoke explode with a huge delay for some reason?
	if exploded:
		for obj_name in objs_map:
			var obj = objs_map[obj_name]
			if obj and not obj.disabled and obj.id == id and collision_box.overlaps(obj.collision_box) and obj != Hitbox and obj != self:
				#print('overlapping', obj)
				if "percht_smoke" in obj:
					obj.schedule_explode()
	
