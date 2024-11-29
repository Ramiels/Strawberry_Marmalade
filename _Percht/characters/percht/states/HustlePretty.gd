extends "res://_Percht/PerchtMove.gd"


var can_apply_sadness = false
var is_whip_move = true

func _enter():
	can_apply_sadness = host.combo_count <= 0

func _frame_21():
	host.gain_super_meter_raw(host.MAX_SUPER_METER)
	host.unlock_achievement("ACH_HUSTLE", true)
	
