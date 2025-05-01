extends PlayerExtra

onready var destination = $VBoxContainer/Destination
onready var smokeshift = $VBoxContainer/Smokeshift
onready var goodie_bag = $VBoxContainer/GoodieBag
onready var quickswap = $VBoxContainer/Quickswap
onready var shift_cancel = $VBoxContainer/ShiftCancel

var no_smokeshift = ["Jump", "DoubleJump", "SuperJump"]

func get_extra():
	var extra = {
		"smokeshift":smokeshift.pressed, 
		"smokeshift_destination":(destination.get_data().x - 1),
		"goodie_bag":goodie_bag.pressed,
		"quickswap":quickswap.pressed,
		"shift_cancel":shift_cancel.pressed
	}
	return extra

func _ready():
	smokeshift.connect("toggled", self, "_on_smokeshift_button_toggled")
	destination.connect("data_changed", self, "_on_destination_changed")
	goodie_bag.connect("toggled", self, "_on_goodie_bag_button_toggled")
	quickswap.connect("toggled", self, "_on_quickswap_button_toggled")
	shift_cancel.connect("toggled", self, "_on_shift_cancel_toggled")

	
func show_options():
	destination.hide()
	smokeshift.disabled = true
	smokeshift.set_pressed_no_signal(false)
	goodie_bag.set_pressed_no_signal(false)
	goodie_bag.visible = false
	quickswap.visible = false
	
	shift_cancel.visible = fighter.smokeshifting
	
	if fighter.can_smokeshift and (fighter.current_smoke != null or fighter.cloak_current):
		smokeshift.disabled = false
	
	if fighter.cloak_current and fighter.smoke_cloak:
		smokeshift.set("custom_colors/font_color", Color("d440b6"))
		smokeshift.set("custom_colors/font_color_focus", Color("d440b6"))
		smokeshift.set("custom_colors/font_color_hover_pressed", Color("d440b6"))
		smokeshift.set("custom_colors/font_color_hover", Color("d440b6"))
		smokeshift.set("custom_colors/font_color_pressed", Color("d440b6"))
	else:
		smokeshift.set("custom_colors/font_color", Color("f0f0f0"))
		smokeshift.set("custom_colors/font_color_focus", Color("f0f0f0"))
		smokeshift.set("custom_colors/font_color_hover_pressed", Color("f0f0f0"))
		smokeshift.set("custom_colors/font_color_hover", Color("f0f0f0"))
		smokeshift.set("custom_colors/font_color_pressed", Color("f0f0f0"))
	
	if fighter.goodie_bag != null and is_instance_valid(fighter.objs_map[fighter.goodie_bag]):
		goodie_bag.visible = true
	
	if fighter.current_state().name in ["Knockdown", "HardKnockdown"]:
		smokeshift.set_pressed_no_signal(false)
		smokeshift.disabled = true
		destination.hide()
	
	block_jump_disable()
	
	destination.min_value = 1
	destination.max_value = len(fighter.smoke_projectiles)
	destination.get_node("Direction").min_value = destination.min_value
	destination.get_node("Direction").max_value = destination.max_value

func block_jump_disable():
	var move_state = fighter.current_state()
	
	if move_state is CharacterState:
		var disable = false
		if move_state.type == CharacterState.ActionType.Defense and not (move_state.name == "Taunt" or move_state.name == "TauntUgly"):
			disable = true
		
		if move_state.name in no_smokeshift and selected_move == null:
			disable = true
		
		if disable:
			smokeshift.set_pressed_no_signal(false)
			smokeshift.disabled = true
			destination.hide()

func update_selected_move(move_state):
	.update_selected_move(move_state)
	
	if fighter.can_smokeshift and (fighter.current_smoke != null or fighter.cloak_current):
		smokeshift.disabled = false
	
	shift_cancel.visible = fighter.smokeshifting
	
	if fighter.current_state().name in ["Knockdown", "HardKnockdown"]:
		smokeshift.set_pressed_no_signal(false)
		smokeshift.disabled = true
		destination.hide()
	
	if selected_move:
		if (selected_move.type == CharacterState.ActionType.Defense and not (move_state.name == "Taunt" or move_state.name == "TauntUgly")) or selected_move.name in no_smokeshift:
			smokeshift.set_pressed_no_signal(false)
			smokeshift.disabled = true
			destination.hide()
	
	quickswap.visible = false
	if move_state:
		if move_state.get_host_command("try_quickswap"):
			quickswap.visible = true
	
	block_jump_disable()

func _on_smokeshift_button_toggled(enabled):
	destination.visible = enabled
	if enabled:
		shift_cancel.set_pressed_no_signal(false)
	emit_signal("data_changed")

func _on_destination_changed():
	emit_signal("data_changed")

func _on_goodie_bag_button_toggled(enabled):
	emit_signal("data_changed")

func _on_quickswap_button_toggled(enabled):
	emit_signal("data_changed")

func _on_shift_cancel_toggled(enabled):
	emit_signal("data_changed")
	if enabled:
		destination.visible = false
		smokeshift.set_pressed_no_signal(false)

func reset():
	smokeshift.set_pressed_no_signal(false)
	goodie_bag.set_pressed_no_signal(false)
	destination.get_node("Direction").value = 1
	quickswap.set_pressed_no_signal(false)
	shift_cancel.set_pressed_no_signal(false)
	#pass
