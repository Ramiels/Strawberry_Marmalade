extends CharacterState

var old_kind

func _enter():
	if host.kind == "Pretty":
		anim_name = "QuickswapPretty"
	else:
		anim_name = "QuickswapUgly"
	old_kind = host.kind

func _frame_4():
	if old_kind == "Pretty":
		host.change_kind("Ugly")
	else:
		host.change_kind("Pretty")
