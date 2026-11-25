extends BaseProjectile

var WISPVANISHEFFECT = preload("res://_Percht/characters/percht/WispVanishEffect.tscn")

const base_move_dist = "3"
const speed_ramp_per_tick = "0.5"
var enable_accel = true
var wisp_dir = {
	
}
var distance = ""

var scheduled_disable = false
var scheduled_lock = false
var scheduled_lock_tick = 0

var torched_objs: Array = []



func _ready():
	pass

func tick():
	.tick()
	
	print(torched_objs)
	
	if scheduled_disable:
		disable()
	
	if scheduled_lock:
		if scheduled_lock_tick == 0:
			lock_wisp()
		scheduled_lock_tick -= 1
	
	var move_dist = fixed.add(base_move_dist, fixed.mul(speed_ramp_per_tick, str(current_tick)) if enable_accel else "0")
	
	if fixed.gt(distance, "0"):
		if fixed.gt(distance, move_dist):
			move_directly_relative(fixed.mul(wisp_dir.x, move_dist), fixed.mul(wisp_dir.y, move_dist))
			distance = fixed.sub(distance, move_dist)
		else:
			move_directly_relative(fixed.mul(wisp_dir.x, move_dist), fixed.mul(wisp_dir.y, move_dist))
			distance = "0"
			schedule_lock()
	pass


func schedule_disable():
	scheduled_disable = true

func schedule_lock():
	scheduled_lock = true
	scheduled_lock_tick = 1

func lock_wisp():
	change_state("Burst")
	torched_objs.clear()
	has_projectile_parry_window = false

func set_data(data_x, data_y, x_mult, y_mult, fast = true):
	wisp_dir = fixed.normalized_vec(data_x, data_y)
	distance = fixed.vec_len(fixed.mul(data_x, x_mult), fixed.mul(data_y, y_mult))
	enable_accel = fast
	pass

func disable():
	$Flip/Particles/ParticleEffect.queue_free()
	
	spawn_particle_effect_relative(WISPVANISHEFFECT, Vector2())
	play_sound("WispChime")
	play_sound("Swish")
	
	.disable()
