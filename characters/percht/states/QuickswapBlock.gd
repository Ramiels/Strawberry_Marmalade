extends CharacterState

var old_kind

func _enter():
	if host.kind == "Pretty":
		anim_name = "QuickswapPretty"
		host.play_sound("PrettyQuickswap")
	else:
		anim_name = "QuickswapUgly"
		host.play_sound("UglyQuickswap")
	old_kind = host.kind

func _frame_1():
	if old_kind == "Pretty":
		host.change_kind("Ugly")
	else:
		host.change_kind("Pretty")
