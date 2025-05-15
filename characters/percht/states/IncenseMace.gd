extends "res://_Percht/PerchtMove.gd"

func _on_hit_something(obj, hitbox):
	if obj == host.opponent:
		host.incense_mace()
		host.play_sound("Bell1")
		host.play_sound("SmokeSpawn")
		print("incense")
	
	._on_hit_something(obj, hitbox)
