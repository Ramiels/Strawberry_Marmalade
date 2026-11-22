extends "res://_Percht/PerchtMove.gd"

onready var hitbox = $ReelSweptHitbox

var is_whip_move = true

var default_length = 135

func _ready():
	pass

func _enter():
	host.whip_arm_sprite.visible = true
	host.whip_arm_sprite.z_index = -1
	
	var whip_dir = xy_to_dir(data.x, data.y)
	
	if data:
		#hitbox.to_x = fixed.ceil(fixed.mul(default_length, fixed.div(str(data.x), "100")))
		#hitbox.to_y = fixed.ceil(fixed.mul(default_length, fixed.div(str(data.y), "100")))
		
		#hitbox.dir_x = fixed.round(fixed.div(str(data.x), "-100"))
		#hitbox.dir_y = fixed.round(fixed.div(str(data.y), "-100"))
		
		hitbox.to_x = fixed.ceil(fixed.mul(str(default_length * host.get_facing_int()), whip_dir.x))
		hitbox.to_y = fixed.ceil(fixed.mul(str(default_length), whip_dir.y))
		
		hitbox.dir_x = fixed.round(fixed.mul(whip_dir.x, str(host.get_facing_int() * -1)))
		hitbox.dir_y = fixed.round(fixed.mul(whip_dir.y, "-1"))
		
		
		host.whip_arm_sprite.rotation = Vector2(data.x*host.get_facing_int(), data.y).angle()
	

func _frame_0():
	
	
	
	pass

func _frame_10():
	host.whip_arm_sprite.z_index = 1

func _tick():
	host.whip_arm_sprite.frame = current_tick



func check_previous_turn():
	if host.whip_combo_previous_turn == false:
		host.whip_combo = false

func _exit():
	host.whip_arm_sprite.visible = false

func is_usable():
	var earliest_base = 99999
	for child in get_children():
		if child is Hitbox:
			if child.start_tick < earliest_base:
				earliest_base = child.start_tick
	if host.whip_combo: host.change_action_e_hitbox_frame(get_name(), earliest_base-3)
	else: host.change_action_e_hitbox_frame(get_name(), earliest_base)
	
	return .is_usable()
