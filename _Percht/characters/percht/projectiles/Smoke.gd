extends BaseProjectile

var percht_smoke = true

func disable():
	.disable()
	creator.smoke_projectiles.erase(obj_name)
