extends "res://_Percht/PerchtMove.gd"


var can_apply_sadness = false

func _enter():
	can_apply_sadness = host.combo_count <= 0

func _frame_4():
	host.play_sound("Block")
	pass

#swish sfx not playing, needs fixing
func _frame_16():
	host.play_sound("Swish")
	pass

func _frame_24():
	host.play_sound("Swish")
	pass
	
func _frame_32():
	host.play_sound("Swish")
	pass


func _frame_44():
	host.gain_super_meter_raw(host.MAX_SUPER_METER)
	host.unlock_achievement("ACH_HUSTLE", true)
