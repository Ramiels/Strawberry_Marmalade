extends ActionUIData

func on_button_selected():
	.on_button_selected()
	print('init')
	print(fighter, fighter.smoke_projectiles)
	$Destination.min_value = 1
	$Destination.max_value = len(fighter.smoke_projectiles)
	$Destination/Direction.min_value = $Destination.min_value
	$Destination/Direction.max_value = $Destination.max_value
	
	$Destination/Direction.value = 1
