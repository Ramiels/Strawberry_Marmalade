extends Fighter

var kind : String = "Pretty"
var smoke_projectiles = []

var mandarin = preload("res://_Percht/characters/percht/Mandarin/mandarin.png")
var peanut = preload("res://_Percht/characters/percht/Peanut/peanut.png")

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

var current_smoke = 0
var can_smokeshift = false

var whip_combo = false

var goodie_bag = null

onready var smokeshift_particles = $"%SmokeshiftParticles"

func _ready():
	smokeshift_particles.visible = true

func change_kind(new_kind):
	kind = new_kind
	if kind == "Ugly":
		# Placeholder
		default_hurtbox.width = 16
		default_hurtbox.height = 17
		default_hurtbox.x = 0
		default_hurtbox.y = -17
	else:
		# Placeholder
		default_hurtbox.width = 14
		default_hurtbox.height = 16
		default_hurtbox.x = 0
		default_hurtbox.y = -16
		
		collision_box

func _draw():
	var curr_state = current_state()
	var anim_name = curr_state.anim_name

	
	# This is ATROCIOUS.
	if not anim_name.ends_with("BOTH"):
		if anim_name.ends_with("Pretty"):
			anim_name.erase(anim_name.length() - 6, 6)
		if anim_name.ends_with("Ugly"):
			anim_name.erase(anim_name.length() - 4, 4)
		
		anim_name += kind
	
	curr_state.anim_name = anim_name
	
	#if not is_ghost:
	#	print("_draw() ", kind)
	#	print(curr_state, curr_state.anim_name)
	
	._draw()

func overlapping_smoke():
	var overlapped_smoke = null
	for obj_name in objs_map:
		var obj = objs_map[obj_name]
		if obj and not obj.disabled and obj.id == id and hurtbox.overlaps(obj.hurtbox) and obj != Hitbox:
			#print('overlapping', obj)
			if "percht_smoke" in obj:
				overlapped_smoke = obj
				#print('overlapped_smoke')

	return overlapped_smoke

func tick():
	for smoke in smoke_projectiles:
		if !obj_from_name(smoke):
			smoke_projectiles.erase(smoke)
	
	if overlapping_smoke() != null:
		current_smoke = overlapping_smoke()
		can_smokeshift = true
	else:
		current_smoke = null
		can_smokeshift = false
	
	if smokeshift_penalty_frames > 0:
		smokeshift_penalty_frames -= 1
		current_state().current_tick -= 1
		current_state().current_real_tick -= 1

	if smokeshifting:
		can_smokeshift = false
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
	
	.tick()

func on_got_hit():
	end_smokeshift()

func smokeshift(smoke_index):
	var smoke_obj = objs_map[smoke_projectiles[smoke_index]]
	var smoke_pos = smoke_obj.get_pos()
	
	smoke_pos.y += 20
	
	smokeshift_pos_x = smoke_pos.x
	smokeshift_pos_y = smoke_pos.y
	
	smokeshift_particles.start_emitting()
	
	if smoke_pos.y < 0:
		set_grounded(false)

	smokeshift_penalty_frames = 2
	
	print(current_smoke)
	if current_smoke != null:
		current_smoke.schedule_disable()
	current_smoke = null
	
	smokeshifting = true
	
	smokeshift_frames = 100
	if smoke_pos.y <= -10:
		smokeshift_frames = 10
		smokeshift_move()

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
	
	var vel = fixed.normalized_vec_times(str(diff_x), str(diff_y), speed)
	
	#print(speed)
	
	apply_force(vel.x, vel.y)
		
	if fixed.le(dist, SMOKESHIFT_MAX_RANGE):
		end_smokeshift()

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
		smokeshift_destination = extra.smokeshift_destination
	
	if extra.has("goodie_bag"):
		if extra.goodie_bag and goodie_bag != null and is_instance_valid(objs_map[goodie_bag]):
			objs_map[goodie_bag].explode()

func on_state_started(state):
	if "is_whip_move" in state:
		if whip_combo:
			state.current_tick += 3
		
		whip_combo = true
	else:
		whip_combo = false
	
	.on_state_started(state)
