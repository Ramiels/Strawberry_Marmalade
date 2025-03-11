extends "res://_Percht/PerchtMove.gd"


var can_apply_sadness = false

func _enter():
	can_apply_sadness = host.combo_count <= 0

func _frame_4():
	host.play_sound("Block")
	pass

func _frame_14():
	host.play_sound("Swish")
	pass

func _frame_22():
	host.play_sound("Swish")
	pass
	
func _frame_30():
	host.play_sound("Swish")
	pass


func _frame_44():
	host.gain_super_meter_raw(host.MAX_SUPER_METER)
	host.unlock_achievement("ACH_HUSTLE", true)
