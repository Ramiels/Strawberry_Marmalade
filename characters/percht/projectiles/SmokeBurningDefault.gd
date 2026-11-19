extends "res://_Percht/characters/percht/projectiles/SmokeState.gd"


func _ready():
	pass

func _on_hit_something(obj, hitbox):
	lifetime -= 20

func on_got_blocked():
	.on_got_blocked()
	lifetime -= 40
	pass

func _tick():
	._tick()
	if current_tick % 20 == 0:
		host.play_sound("Fire")
	pass
