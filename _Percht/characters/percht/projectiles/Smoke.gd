extends BaseProjectile

var percht_smoke = true
var smokescreen = false
var scheduled_disable = false
var scheduled_explode = false
var scheduled_explode_tick = 0

var EXPLOSION = preload("res://_Percht/characters/percht/projectiles/SmokeExplosion.tscn")

func copy_to(f):
	.copy_to(f)
	f.scheduled_disable = scheduled_disable

func disable():
	.disable()
	$Flip/Particles/ParticleEffect.queue_free()
	#creator.smoke_projectiles.erase(obj_name)

func schedule_disable():
	scheduled_disable = true

func smokescreen_disable():
	#print(smokescreen)
	if smokescreen:
		schedule_disable()

func tick():
	.tick()
	hurtbox
	
	if scheduled_disable:
		disable()
	if scheduled_explode:
		if scheduled_explode_tick == 0:
			explode()
		scheduled_explode_tick -= 1

func schedule_explode():
	scheduled_explode = true
	scheduled_explode_tick = 2

func explode():
	disable()
	spawn_object(EXPLOSION, 0, 0)

	for obj_name in objs_map:
		var obj = objs_map[obj_name]
		if obj and not obj.disabled and obj.id == id and collision_box.overlaps(obj.collision_box) and obj != Hitbox and obj != self:
			#print('overlapping', obj)
			if "percht_smoke" in obj:
				obj.schedule_explode()
	
