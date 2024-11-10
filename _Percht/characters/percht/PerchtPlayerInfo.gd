extends PlayerInfo

func set_fighter(fighter):
	.set_fighter(fighter)
	if player_id == 2:
		$WhipLabel.align = Label.ALIGN_RIGHT

func _process(delta):
	if is_instance_valid(fighter):
		$WhipLabel.visible = fighter.whip_combo
