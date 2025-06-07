extends Fighter

var kind : String = "Pretty"
var smoke_projectiles = []
var incense_mace_smoke

var mandarin = preload("res://_Percht/characters/percht/Mandarin/mandarin.png")
var peanut = preload("res://_Percht/characters/percht/Peanut/peanut.png")

var SMOKE_SCENE = preload("res://_Percht/characters/percht/projectiles/Smoke.tscn")

var smokeshift_penalty_frames = 0

var smokeshift_pos_x
var smokeshift_pos_y

var SMOKESHIFT_SPEED = 10
var SMOKESHIFT_MAX_RANGE = "35"
var SMOKESHIFT_FALLOFF_RANGE = "700"
var SMOKESHIFT_AIR_MULT = "1.0"

var smokeshift_frames = 0
var smokeshift_now = false
var smokeshift_destination = 0
var smokeshifting = false
var shift_cancel_now = false

var current_smoke = null
var can_smokeshift = false
var smoke_cloak = false
var cloak_current = false

var QUICKSWAP_HITLAG = 7

var quickswap_buffer = false
var quickswap = false
var quickswap_hit = false

var whip_combo = false
var whip_combo_previous_turn = false # this is for whip juggle specifically so the variations donw auto speed-up
var goodie_bag = null
var goodie_bag_delay = 0
var guardpoint = false
var restand_grab_used = false
var swap_scaling_reduction = 2

export var mask_color : Color

onready var smokeshift_particles = $"%SmokeshiftParticles"
onready var smoke_cloak_particles = $"%SmokeCloakParticles"
onready var scissors_sprite = $"%ScissorsSprite"

func _ready():
	#._ready()
	smokeshift_particles.visible = true
	smoke_cloak_particles.visible = true

func apply_style(style):
	.apply_style(style)

	if style != null and not is_ghost:
		var e2 = style.get("extra_color_1")
		sprite.get_material().set_shader_param("extra_replace_color_3", mask_color)
		sprite.get_material().set_shader_param("extra_color_3", e2)
		sprite.get_material().set_shader_param("use_extra_color_3", true)
	if is_ghost or style == null or !use_extra_color_1:
		sprite.get_material().set_shader_param("use_extra_color_3", true)
		sprite.get_material().set_shader_param("extra_replace_color_3", mask_color)
		sprite.get_material().set_shader_param("extra_color_3", extra_color_1)

func copy_to(t):
	.copy_to(t)
	t.quickswap = quickswap
	t.quickswap_hit = quickswap_hit
	t.whip_combo = whip_combo

func change_kind(new_kind):
	kind = new_kind
	if kind == "Ugly":
		default_hurtbox.width = 16
		default_hurtbox.height = 17
		default_hurtbox.x = 0
		default_hurtbox.y = -17
	else:
		default_hurtbox.width = 14
		default_hurtbox.height = 16
		default_hurtbox.x = 0
		default_hurtbox.y = -16
	

func try_quickswap(swap_scaling_reduction = 0):
	#print(quickswap, quickswap_buffer)
	if got_parried:
		return 
	if not quickswap:
		return 
	quickswap = false
	
	if quickswap_hit:
		opponent.hitlag_ticks += QUICKSWAP_HITLAG

	combo_count = max(1, combo_count - swap_scaling_reduction)
	
	change_state("Quickswap")

func _draw():
	var curr_state = current_state()
	var anim_name = curr_state.anim_name
	
	if is_ghost:
		$GuardpointLabel.visible = guardpoint
	else:
		$GuardpointLabel.visible = false
	
	._draw()

func consume_smoke():
	if current_smoke != null and is_instance_valid(objs_map[current_smoke]):
		objs_map[current_smoke].schedule_disable()
	elif smoke_cloak:
		end_cloak()
		#cloak_current = false

func overlapping_smoke():
	var overlapped_smoke = null
	for obj_name in objs_map:
		var obj = objs_map[obj_name]
		if obj and not obj.disabled and obj.id == id and hurtbox.overlaps(obj.collision_box) and obj != Hitbox:
			#print('overlapping', obj)
			if "percht_smoke" in obj and obj.name in smoke_projectiles:
				overlapped_smoke = obj.name
				#print('overlapped_smoke')

	return overlapped_smoke

func tick():
	if smokeshift_penalty_frames > 0:
		smokeshift_penalty_frames -= 1
		#current_state().current_tick = -50
		#current_state().current_real_tick = -50
	
	if shift_cancel_now:
		print('cancel')
		end_smokeshift()
	
	if smokeshifting:
		colliding_with_opponent = false
		
		if smokeshift_pos_y > -10:
			smokeshift_move()
	
	if smokeshift_frames > 0:
		smokeshift_frames -= 1
		if !smokeshift_particles.emitting:
			smokeshift_particles.start_emitting()
		
		if smokeshift_frames <= 0:
			end_smokeshift()
	
	if smokeshift_now:
		smokeshift_now = false
		smokeshift(smokeshift_destination)
	
	if goodie_bag_delay > 0:
		goodie_bag_delay -= 1
	
	if quickswap_buffer:
		quickswap_buffer = false
		quickswap = true
	
	if smoke_cloak:
		if !smoke_cloak_particles.emitting:
			smoke_cloak_particles.start_emitting()
	
	if incense_mace_smoke and incense_mace_smoke in objs_map and is_instance_valid(objs_map[incense_mace_smoke]) and incense_mace_smoke in smoke_projectiles:
		var smoke_obj = objs_map[incense_mace_smoke]
		smoke_obj.set_pos(opponent.get_pos().x, opponent.get_pos().y - 20)
	
	.tick()
	
	for smoke in smoke_projectiles:
		if !obj_from_name(smoke):
			#print('test')
			smoke_projectiles.erase(smoke)
	
	cloak_current = false
	
	if overlapping_smoke() != null:
		current_smoke = overlapping_smoke()
		can_smokeshift = true
	else:
		current_smoke = null
		can_smokeshift = false
		#print(smoke_projectiles)
		if smoke_cloak and smoke_projectiles.size() > 0:
			can_smokeshift = true
			cloak_current = true
			
		
	
	if !is_grounded() and air_movements_left < 1:
		can_smokeshift = false

func state_tick():
	if smokeshift_penalty_frames <= 0:
		.state_tick()

func on_got_hit():
	end_smokeshift()

func smokeshift(target_smoke):
	if target_smoke in objs_map and is_instance_valid(objs_map[target_smoke]) and target_smoke in smoke_projectiles:
		var smoke_obj = objs_map[target_smoke]
		var smoke_pos = smoke_obj.get_pos()
		
		smoke_pos.y += 20
		
		smokeshift_pos_x = smoke_pos.x
		smokeshift_pos_y = smoke_pos.y
		
		smokeshift_particles.start_emitting()
		
		if !is_grounded():
			air_movements_left -= 1
		
		if smoke_pos.y < 0:
			set_grounded(false)

		smokeshift_penalty_frames = 2
		
		#print("current_smoke:", current_smoke)
		if current_smoke != null and is_instance_valid(objs_map[current_smoke]):
			objs_map[current_smoke].schedule_disable()
		if cloak_current:
			end_cloak()
			cloak_current = false
		
		current_smoke = null
		
		smokeshifting = true
		
		smokeshift_frames = 100
		if smoke_pos.y <= -10:
			smokeshift_frames = 10
			smokeshift_move()
		
		play_sound("Smokeshift")

func smokeshift_move():
	var diff_x = fixed.sub(str(smokeshift_pos_x), str(get_pos().x))
	var diff_y = fixed.sub(str(smokeshift_pos_y), str(get_pos().y))
	
	var dist = fixed.vec_dist(str(get_pos().x), str(get_pos().y), str(smokeshift_pos_x), str(smokeshift_pos_y))
	var mult = "0"
	
	var falloff = SMOKESHIFT_FALLOFF_RANGE
	
	if fixed.ge(dist, falloff):
		mult = "1"
	else:
		mult = fixed.div(dist, falloff)
	
	var speed = fixed.mul(str(SMOKESHIFT_SPEED), mult)
	
	if smokeshift_pos_y <= -10:
		speed = fixed.mul(str(SMOKESHIFT_SPEED), SMOKESHIFT_AIR_MULT)
	else:
		if fixed.le(dist, SMOKESHIFT_MAX_RANGE):
			end_smokeshift()
	
	var vel = fixed.normalized_vec_times(str(diff_x), str(diff_y), speed)
	
	#print(speed)
	
	apply_force(vel.x, vel.y)

func end_smokeshift():
	
	smokeshifting = false
	smokeshift_frames = 0
	smokeshift_particles.stop_emitting()

func apply_grav():
	if !smokeshifting:
		.apply_grav()

func smoke_teleport(smoke_index):
	if smoke_index < len(smoke_projectiles):
		var smoke_obj = objs_map[smoke_projectiles[smoke_index]]
		var smoke_pos = smoke_obj.get_pos()
		
		if smoke_pos.y < 0:
			set_grounded(false)
			
		set_pos(smoke_pos.x, smoke_pos.y)
		smoke_obj.disable()

func process_extra(extra):
	.process_extra(extra)
	
	if extra.has("smokeshift") and extra.has("smokeshift_destination"):
		smokeshift_now = extra.smokeshift
		#print(extra.smokeshift_destination)
		if len(smoke_projectiles) > extra.smokeshift_destination and extra.smokeshift_destination >= 0:
			#print("processing extra ", extra.smokeshift_destination)
			smokeshift_destination = smoke_projectiles[extra.smokeshift_destination]
	
	if extra.has("shift_cancel"):
		shift_cancel_now = extra.shift_cancel
	
	if extra.has("goodie_bag"):
		if extra.goodie_bag and goodie_bag != null and is_instance_valid(objs_map[goodie_bag]):
			objs_map[goodie_bag].explode()
	
	if extra.has("quickswap"):
		quickswap_buffer = extra.quickswap

func goodie_bag_die():
	goodie_bag_delay = 20

func on_state_started(state):
	if "is_whip_move" in state:
		if whip_combo:
			state.current_tick += 3
			whip_combo_previous_turn = true
		
		whip_combo = true
	else:
		if whip_combo:
			whip_combo_previous_turn = false
		
		whip_combo = false
	
	.on_state_started(state)

func on_state_ended(state):
	#quickswap_buffer = false
	if not "keep_quickswap" in state:
		quickswap = false
		quickswap_hit = false
	
	.on_state_ended(state)

func on_attack_blocked():
	if quickswap:
		quickswap = false
		change_state("QuickswapBlock")

func can_block_cancel():
	if current_state().name == "QuickswapBlock":
		return false
	return .can_block_cancel()

func _on_hit_something(obj, hitbox):
	if quickswap:
		quickswap_hit = true
	
	._on_hit_something(obj, hitbox)

func reset_combo():
	.reset_combo()

	restand_grab_used = false

func block_hitbox(hitbox, force_parry = false, force_block = false, ignore_guard_break = false, autoblock_armor = false):
	.block_hitbox(hitbox, force_parry, force_block, ignore_guard_break, autoblock_armor)
	if current_state().get("IS_NEW_PARRY"):
		var anim_name = current_state().anim_name

		anim_name = anim_name + kind

		current_state().anim_name = anim_name
		current_state().update_sprite_frame()

func start_cloak():
	smoke_cloak = true
	smoke_cloak_particles.start_emitting()

func end_cloak():
	smoke_cloak = false
	smoke_cloak_particles.stop_emitting()

func incense_mace():
	if not (incense_mace_smoke and incense_mace_smoke in objs_map and is_instance_valid(objs_map[incense_mace_smoke]) and incense_mace_smoke in smoke_projectiles):
		var smoke = spawn_object(SMOKE_SCENE, 0, 0, true)

		smoke.set_grounded(false)
		
		smoke.state_machine.get_node("Default").lifetime = 100
			
		incense_mace_smoke = smoke.obj_name
		smoke_projectiles.append(smoke.obj_name)
	else:
		objs_map[incense_mace_smoke].state_machine.get_state("Default").lifetime += 100
