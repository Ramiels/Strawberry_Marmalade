extends "res://_Percht/PerchtMove.gd"

const SPEED = "10"

var move_x
var move_y
var dir_x
var dir_y

var offset_y = -16

var original_hitbox_pos = []

func _ready():
	if len(original_hitbox_pos) == 0:
		for box in get_children():
			if box is Hitbox:
				original_hitbox_pos.append([box.x, box.y])

func _frame_0():
	var move = xy_to_dir(data.x, data.y, SPEED)
	move_x = move.x
	move_y = move.y
	dir_x = fixed.div(move_x, SPEED)
	dir_y = fixed.div(move_y, SPEED)

	var angle = fixed.vec_to_angle(dir_x, dir_y)
	for i in get_child_count():
		var box = get_children()[i]
		if box is Hitbox:
			var hitbox_vec = fixed.rotate_vec(str(original_hitbox_pos[i][0]), str(original_hitbox_pos[i][1]), angle)
			#box.x = (fixed.round(hitbox_vec.x) + pivot_x) * host.get_facing_int()
			#box.y = fixed.round(hitbox_vec.y) + pivot_y
			box.x = (fixed.round(hitbox_vec.x)) * host.get_facing_int()
			box.y = fixed.round(hitbox_vec.y) + offset_y
			box.dir_x = fixed.mul(dir_x, str(host.get_facing_int()))
			box.dir_y = dir_y

	host.scissors_sprite.visible = true
	host.sprite.visible = false
	host.scissors_sprite.animation = "ScissorsUgly"
	host.scissors_sprite.frame = 0
	
	if data and !host.is_grounded():
		host.scissors_sprite.rotation = Vector2(data.x*host.get_facing_int(), data.y).angle() + PI/2


func _frame_4():
	host.reset_momentum()
	
	if data:
		var dir = xy_to_dir(data.x, data.y, SPEED)
		host.scissors_sprite.rotation = Vector2(data.x*host.get_facing_int(), data.y).angle()
		host.apply_force(dir.x, dir.y)
	
		spawn_particle_relative(particle_scene, Vector2(0, 0), Vector2(data.y, -data.x))
	
func _tick():
	#print(host.get_vel())
	if current_tick >= 13:
		host.apply_grav()
	
	host.scissors_sprite.frame += 1

func _exit():
	host.scissors_sprite.visible = false
	host.sprite.visible = true
