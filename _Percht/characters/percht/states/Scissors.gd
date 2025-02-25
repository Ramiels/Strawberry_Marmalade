extends "res://_Percht/PerchtMove.gd"

const SPEED = "25"
const HITBOX_X = "43"
const HITBOX_Y = "-18"
const HITBOX_X2 = "50"
const HITBOX_Y2 = "-53"
const HITBOX_X3 = "28"
const HITBOX_Y3 = "-55"
const HITBOX_X4 = "28"
const HITBOX_Y4= "19"
const HITBOX_X5 = "50"
const HITBOX_Y5 = "17"

var move_x
var move_y
var dir_x
var dir_y

onready var hitbox1 = $Hitbox1
onready var hitbox2 = $Hitbox2
onready var hitbox3 = $Hitbox3
onready var hitbox4 = $Hitbox4
onready var hitbox5 = $Hitbox5	

func _frame_0():
	var move = xy_to_dir(data.x, data.y, SPEED)
	move_x = move.x
	move_y = move.y
	dir_x = fixed.div(move_x, SPEED)
	dir_y = fixed.div(move_y, SPEED)
	var pivot_x = 0
	var pivot_y = - 18
	var pivot_x2 = 0
	var pivot_y2 = - 53
	var pivot_x3 = 0
	var pivot_y3 = - 55
	var pivot_x4 = 0
	var pivot_y4 = 19
	var pivot_x5 = 0
	var pivot_y5 = 17
	var angle = fixed.vec_to_angle(dir_x, dir_y)
	var hitbox_vec = fixed.rotate_vec(HITBOX_X, "0", angle)
	var hitbox_vec2 = fixed.rotate_vec(HITBOX_X2, "0", angle)
	var hitbox_vec3 = fixed.rotate_vec(HITBOX_X3, "0", angle)
	var hitbox_vec4 = fixed.rotate_vec(HITBOX_X4, "0", angle)
	var hitbox_vec5 = fixed.rotate_vec(HITBOX_X5, "0", angle)
	hitbox1.x = (fixed.round(hitbox_vec.x) + pivot_x) * host.get_facing_int()
	hitbox1.y = fixed.round(hitbox_vec.y) + pivot_y
	hitbox1.dir_x = fixed.mul(dir_x, str(host.get_facing_int()))
	hitbox1.dir_y = dir_y
	hitbox2.x = (fixed.round(hitbox_vec2.x) + pivot_x2) * host.get_facing_int()
	hitbox2.y = fixed.round(hitbox_vec2.y) + pivot_y2
	hitbox2.dir_x = fixed.mul(dir_x, str(host.get_facing_int()))
	hitbox2.dir_y = dir_y
	hitbox3.x = (fixed.round(hitbox_vec3.x) + pivot_x3) * host.get_facing_int()
	hitbox3.y = fixed.round(hitbox_vec3.y) + pivot_y3
	hitbox3.dir_x = fixed.mul(dir_x, str(host.get_facing_int()))
	hitbox3.dir_y = dir_y
	hitbox4.x = (fixed.round(hitbox_vec4.x) + pivot_x4) * host.get_facing_int()
	hitbox4.y = fixed.round(hitbox_vec4.y) + pivot_y4
	hitbox4.dir_x = fixed.mul(dir_x, str(host.get_facing_int()))
	hitbox4.dir_y = dir_y
	hitbox5.x = (fixed.round(hitbox_vec5.x) + pivot_x5) * host.get_facing_int()
	hitbox5.y = fixed.round(hitbox_vec5.y) + pivot_y5
	hitbox5.dir_x = fixed.mul(dir_x, str(host.get_facing_int()))
	hitbox5.dir_y = dir_y
#God take me out of this hell
	
	
	
	

func _frame_2():
	if data:
		var dir = xy_to_dir(data.x, data.y, SPEED)
		host.sprite.rotation = Vector2(data.x*host.get_facing_int(), data.y).angle()
		host.apply_force(dir.x, dir.y)
	
func _exit():
	host.sprite.rotation = 0
