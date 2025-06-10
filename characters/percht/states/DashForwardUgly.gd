extends "res://characters/states/Dash.gd"

export  var _c_Percht = 0
export (String) var kind
export (bool) var kind_locked = false

func is_usable():
	var correct = true
	if kind != "":
		if host.kind != kind and kind_locked:
			correct = false

	return .is_usable() and correct

func _enter():
	var next_state = ._enter()
	
	anim_name = "DashForwardUgly"
	
	if not host.sprite.is_connected("frame_changed", self, "on_sprite_frame_changed"):
		host.sprite.connect("frame_changed", self, "on_sprite_frame_changed")
	setup_hurtboxes()
	
	return next_state

func on_sprite_frame_changed():
	if not active:
		return 
	if host.sprite.frame == 4 or host.sprite.frame == 12:
		host.play_sound("Block3")
	#if host.sprite.frame == 3 or host.sprite.frame == 0:
	#	host.play_sound("Walk2")

func play_enter_sfx():
	if not same_as_last_state:
		.play_enter_sfx()
