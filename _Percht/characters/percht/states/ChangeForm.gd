extends "res://_Percht/PerchtMove.gd"

func _frame_5():
	print(host.kind)
	if host.kind == "Pretty":
		host.change_kind("Ugly")
	else:
		host.change_kind("Pretty")
