extends "res://_Percht/PerchtMove.gd"

var is_whip_move = true
var hit = false


func _on_hit_something(obj, _hitbox):
	._on_hit_something(obj,_hitbox)
	if obj == host.opponent:
		hit = true
func _frame_8():
	if hit == true:
		get_child(1).active_ticks = 2
		


		
