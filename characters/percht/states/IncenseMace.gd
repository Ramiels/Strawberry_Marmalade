extends "res://_Percht/PerchtMove.gd"

func _on_hit_something(obj, hitbox):
	if obj == host.opponent:
		host.incense_mace()
		print("incense")
	
	._on_hit_something(obj, hitbox)
