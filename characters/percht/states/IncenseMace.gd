extends "res://_Percht/PerchtMove.gd"

func on_got_blocked():
	hit()
	

func _on_hit_something(obj, hitbox):
	if obj == host.opponent:
		hit()
	
	._on_hit_something(obj, hitbox)

func hit():
	host.incense_mace()
	host.play_sound("Bell1")
	host.play_sound("SmokeSpawn")
	print("incense")
