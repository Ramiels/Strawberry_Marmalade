extends PlayerExtra

onready var destination = $VBoxContainer/Destination
onready var smokeshift = $VBoxContainer/Smokeshift
onready var goodie_bag = $VBoxContainer/GoodieBag
onready var quickswap = $VBoxContainer/Quickswap

var no_smokeshift = ["Jump", "DoubleJump", "SuperJump"]

func get_extra():
	var extra = {
		"smokeshift":smokeshift.pressed, 
		"smokeshift_destination":(destination.get_data().x - 1),
		"goodie_bag":goodie_bag.pressed,
		"quickswap":quickswap.pressed
	}
	return extra

func _ready():
	smokeshift.connect("toggled", self, "_on_smokeshift_button_toggled")
	destination.connect("data_changed", self, "_on_destination_changed")
	goodie_bag.connect("toggled", self, "_on_goodie_bag_button_toggled")
	quickswap.connect("toggled", self, "_on_quickswap_button_toggled")

func show_options():
	destination.hide()
	smokeshift.disabled = true
	smokeshift.set_pressed_no_signal(false)
	goodie_bag.set_pressed_no_signal(false)
	goodie_bag.visible = false
	quickswap.visible = false
	
	if fighter.can_smokeshift and fighter.current_smoke != null:
		smokeshift.disabled = false
	
	if fighter.goodie_bag != null and is_instance_valid(fighter.objs_map[fighter.goodie_bag]):
		goodie_bag.visible = true
	
	block_jump_disable()

	destination.min_value = 1
	destination.max_value = len(fighter.smoke_projectiles)
	destination.get_node("Direction").min_value = destination.min_value
	destination.get_node("Direction").max_value = destination.max_value

func block_jump_disable():
	var move_state = fighter.current_state()
	
	if move_state is CharacterState:
		var disable = false
		if move_state.type == CharacterState.ActionType.Defense:
			disable = true
		
		if move_state.name in no_smokeshift and selected_move == null:
			disable = true
		
		if disable:
			smokeshift.set_pressed_no_signal(false)
			smokeshift.disabled = true
			destination.hide()

func update_selected_move(move_state):
	.update_selected_move(move_state)
	
	if fighter.can_smokeshift and fighter.current_smoke != null:
		smokeshift.disabled = false
	
	if selected_move:
		if selected_move.type == CharacterState.ActionType.Defense or selected_move.name in no_smokeshift:
			smokeshift.set_pressed_no_signal(false)
			smokeshift.disabled = true
			destination.hide()
	
	if move_state:
		quickswap.visible = false
		if move_state.get_host_command("try_quickswap"):
			quickswap.visible = true
	
	block_jump_disable()

func _on_smokeshift_button_toggled(enabled):
	destination.visible = enabled
	emit_signal("data_changed")

func _on_destination_changed():
	emit_signal("data_changed")

func _on_goodie_bag_button_toggled(enabled):
	emit_signal("data_changed")

func _on_quickswap_button_toggled(enabled):
	emit_signal("data_changed")

func reset():
	smokeshift.set_pressed_no_signal(false)
	goodie_bag.set_pressed_no_signal(false)
	destination.get_node("Direction").value = 1
	quickswap.set_pressed_no_signal(false)
	#pass
