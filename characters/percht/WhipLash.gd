extends "res://_Percht/PerchtMove.gd"

var is_whip_move = true

var PROJ_SCENE = preload("res://_Percht/characters/percht/projectiles/WhiplashSlash.tscn")

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj.is_in_group("Fighter"):
		var proj = host.spawn_object(PROJ_SCENE, 0, 0, true)
