extends "res://_Percht/PerchtMove.gd"

onready var hitbox = $ReelSweptHitbox

var is_whip_move = true

var default_length = "135"

func _ready():
	pass

func _enter():
	host.whip_arm_sprite.visible = true
	host.whip_arm_sprite.z_index = -1
	
	if data:
		hitbox.to_x = fixed.ceil(fixed.mul(default_length, fixed.div(str(data.x), "100")))
		hitbox.to_y = fixed.ceil(fixed.mul(default_length, fixed.div(str(data.y), "100")))
		
		hitbox.dir_x = fixed.round(fixed.div(str(data.x), "-100"))
		hitbox.dir_y = fixed.round(fixed.div(str(data.y), "-100"))
		
		
		host.whip_arm_sprite.rotation = Vector2(data.x*host.get_facing_int(), data.y).angle()
	

func _frame_0():
	
	
	
	pass

func _frame_10():
	host.whip_arm_sprite.z_index = 1

func _tick():
	host.whip_arm_sprite.frame = current_tick


func _exit():
	host.whip_arm_sprite.visible = false

func check_previous_turn():
	if host.whip_combo_previous_turn == false:
		host.whip_combo = false
