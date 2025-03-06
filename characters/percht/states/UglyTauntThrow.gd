extends ThrowState

func _frame_6():
	host.gain_super_meter_raw(host.MAX_SUPER_METER)
	host.get_opponent().gain_super_meter_raw(host.get_opponent().MAX_SUPER_METER)
