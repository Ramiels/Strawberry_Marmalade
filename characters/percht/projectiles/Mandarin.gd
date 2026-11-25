extends BaseProjectile

var SPLAT = preload("res://_Percht/characters/percht/projectiles/MandarinSplatParticle.tscn")

func _ready():
	pass

func disable():
	spawn_particle_effect_relative(SPLAT, Vector2(0,0))
	.disable()
