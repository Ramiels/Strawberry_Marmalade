extends BaseProjectile

var percht_smoke = true
var smokescreen = false
var scheduled_disable = false

func disable():
	.disable()
	$Flip/Particles/ParticleEffect.queue_free()
	#creator.smoke_projectiles.erase(obj_name)

func schedule_disable():
	scheduled_disable = true

func smokescreen_disable():
	print(smokescreen)
	if smokescreen:
		schedule_disable()

func tick():
	.tick()
	if scheduled_disable:
		disable()
