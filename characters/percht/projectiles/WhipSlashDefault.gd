extends DefaultFireball

func _tick():
	._tick()
	if current_tick < 4:
		host.set_pos(host.creator.get_opponent().get_pos().x, host.creator.get_opponent().get_pos().y - 12)
