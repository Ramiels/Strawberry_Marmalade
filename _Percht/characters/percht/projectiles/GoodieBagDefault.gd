extends DefaultFireball

func _on_hit_something(obj, _hitbox):
	if obj.is_in_group("Fighter"):
		if obj is BaseProjectile:
			if not obj.deletes_other_projectiles:
				return
		
		host.explode()
		fizzle()
