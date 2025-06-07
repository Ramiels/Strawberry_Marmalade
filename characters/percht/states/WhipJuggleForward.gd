extends "res://_Percht/PerchtMove.gd"

var is_whip_move = true

func _enter():
	if data:
		if data.y == -1:
			check_previous_turn()
			return "WhipJuggleUpward"
		elif data.y == 1:
			check_previous_turn()
			return "WhipJuggleDownward"
		elif data.x == -1:
			check_previous_turn()
			return "WhipJuggleBackward"


func check_previous_turn():
	if host.whip_combo_previous_turn == false:
		host.whip_combo = false
