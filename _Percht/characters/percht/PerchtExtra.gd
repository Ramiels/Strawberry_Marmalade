extends PlayerExtra

onready var destination = $VBoxContainer/Destination
onready var smokeshift = $VBoxContainer/Smokeshift

var no_smokeshift = ["Jump", "DoubleJump", "SuperJump"]

func get_extra():
	var extra = {
		"smokeshift":smokeshift.pressed, 
		"smokeshift_destination":(destination.get_data().x - 1)
	}
	return extra

func _ready():
	smokeshift.connect("toggled", self, "_on_smokeshift_button_toggled")
	destination.connect("data_changed", self, "_on_destination_changed")

func show_options():
	destination.hide()
	smokeshift.disabled = true
	smokeshift.set_pressed_no_signal(false)
	
	if fighter.can_smokeshift and fighter.current_smoke != null:
		smokeshift.disabled = false
	
	block_jump_disable()

	destination.min_value = 1
	destination.max_value = len(fighter.smoke_projectiles)
	destination.get_node("Direction").min_value = destination.min_value
	destination.get_node("Direction").max_value = destination.max_value

func block_jump_disable():
	var move_state = fighter.current_state()
	
	if move_state is CharacterState:
		if move_state.type == CharacterState.ActionType.Defense or move_state.name in no_smokeshift:
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
	
	block_jump_disable()

func _on_smokeshift_button_toggled(enabled):
	destination.visible = enabled
	emit_signal("data_changed")

func _on_destination_changed():
	emit_signal("data_changed")

func reset():
	smokeshift.set_pressed_no_signal(false)
	destination.get_node("Direction").value = 1
	#pass
