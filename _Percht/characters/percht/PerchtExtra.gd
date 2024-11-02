extends PlayerExtra

onready var destination = $VBoxContainer/Destination
onready var smokeshift = $VBoxContainer/Smokeshift

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
	
	destination.min_value = 1
	destination.max_value = len(fighter.smoke_projectiles)
	destination.get_node("Direction").min_value = destination.min_value
	destination.get_node("Direction").max_value = destination.max_value

func _on_smokeshift_button_toggled(enabled):
	destination.visible = enabled
	emit_signal("data_changed")

func _on_destination_changed():
	emit_signal("data_changed")

func reset():
	smokeshift.set_pressed_no_signal(false)
	#pass
