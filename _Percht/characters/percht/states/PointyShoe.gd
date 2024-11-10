extends "res://_Percht/PerchtMove.gd"

var got_hit = false

onready var hitbox = $Hitbox



#func _frame_4():
#	host.start_projectile_invulnerability()
#
#func _frame_8():
#	if not got_hit:
#		host.has_hyper_armor = true
#
#func _frame_12():
#	host.has_hyper_armor = false
#	host.end_projectile_invulnerability()
#
#func on_got_hit():
#	hitbox.hitstun_ticks = 20
#	got_hit = true
#	feinting = false
#	host.feinting = false
