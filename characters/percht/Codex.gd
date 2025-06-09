extends Node

func register(codex):
	codex.set_subtitle("The Jolliest")
	
	codex.stances = ["Pretty", "Ugly"]
	
	var ms = codex.moveset
	
	for m in ms:
		var move = ms[m]
		if move.stances == ["Normal"]:
			move.stances = ["All"]
		move.change_stance = ""
	
	var stance_dict = {
		"UglyGrab": "Ugly",
		"UglyAirGrab": "Ugly",
		"Grab": "Pretty",
		"AirGrab": "Pretty",
		"ChangeFormUgly": "Pretty",
		"ChangeFormPretty": "Ugly",
		"Jab": "Pretty",
		"PointyShoe": "Pretty",
		"WhipStrike": "Pretty",
		"WhipStrikeAir": "Pretty",
		"AnkleCutter": "Pretty",
		"Smokescreen": "Pretty",
		"SmokeCloud": "Pretty",
		"SmokeMove": "Pretty",
		"Pierce": "Pretty",
		"SpinClaw": "Ugly",
		"HammerFist": "Ugly",
		"GroundedHammerFistForward": "Ugly",
		"MashClaw1": "Ugly",
		"ClawSlide": "Ugly",
		"ComboClawSlide": "Ugly",
		"GroundSlam": "Ugly",
		"GroundSlamClaw": "Ugly",
		"Cleave": "Pretty",
		"AirZone": "Pretty",
		"LeapSlash": "Pretty",
		"AerialPierce": "Pretty",
		"DashGrab": "Ugly",
		"Whipcopter": "Pretty",
		"AirImpale": "Pretty",
		"Scorch": "Ugly",
		"AirScorch": "Ugly",
		"TorchJab": "Ugly",
		"Incinerate": "Ugly",
		"GoodieBagThrow": "Ugly",
		"AirGoodieBagThrow": "Ugly",
		"ChargePunchDefault": "Ugly",
		"ChargePunch2": "Ugly",
		"ChargePunch3": "Ugly",
		"RestandGrab": "Ugly",
		"RestandGrabGroundD": "Ugly",
		"TauntUgly": "Ugly",
		"Taunt": "Pretty",
		"WhipJuggleForward": "Pretty",
		"Whiplash": "Pretty",
		"SmokeCloak": "Ugly",
		"IncenseMace": "Pretty",
		"Scissors": "Ugly",
		"ScissorsGrounded": "Ugly",
		"LowClaw": "Ugly",
		"AirSlamClaw": "Ugly",
		"JumpscareGrab": "Ugly",
		"SwagDashAirPretty": "Pretty",
		"SwagDashAirUgly": "Ugly",
		"SwagDashGroundPretty": "Pretty",
		"SwagDashGroundUgly": "Ugly",
		"AirMashClaw1": "Ugly",
		"DashForwardUgly": "Ugly",
		"DashBackwardUgly": "Ugly",
		"ChargeDashUgly": "Ugly",
		"JumpUgly": "Ugly",
		"SuperJumpUgly": "Ugly",
		"DoubleJumpUgly": "Ugly",
		
		"DashForward": "Pretty",
		"DashBackward": "Pretty",
		"ChargeDash": "Pretty",
		"Jump": "Pretty",
		"SuperJump": "Pretty",
		"DoubleJump": "Pretty"
	}
	
	for move_name in stance_dict:
		ms[move_name].stances = [stance_dict[move_name]]
	
	ms["WhipStrikeAir"].title = "Whip Strike (Aerial)"
	ms["MashClaw2"].visible = false
	ms["AirMashClaw2"].visible = false
	ms["AirGoodieBagThrow"].visible = false
	ms["GroundSlamClaw"].title = "Ground Slam (Variant)"
	ms["GroundSlamClaw"].desc = "Usable after using Claw"
	ms["GoodieBagThrow"].desc = "Goodie Bag explodes into 3 mandarine projectiles when it hits the opponent or when Goodie Bag toggle is used."
	ms["RestandGrabGroundD"].title = "Restand Grab (Grounded Down)"
	ms["RestandGrabGroundD"].visible = true
	ms["ChargePunch2"].visible = true
	ms["ChargePunch3"].visible = true
	ms["ChargePunch2"].title = "Charge Punch (Charge 2)"
	ms["ChargePunch3"].title = "Charge Punch (Charge 3)"
	ms["AnkleCutter"].desc = "Activates Whip Combo (Doesn't benefit from it.)"
	ms["Jab"].desc = "Activates Whip Combo (Doesn't benefit from it.)"
	ms["SmokeCloak"].desc = "Smoke Cloak sticks to Percht and can be used for smokeshift/smoke dash."
	ms["IncenseMace"].desc = "Attaches a smoke cloud to the opponent. Subsequent hits extend its lifetime."
	ms["HammerFist"].title = "Hammer First (Aerial)"
	ms["ClawSlide"].title = "Claw-By"
	ms["ComboClawSlide"].title = "Claw-By (Variant)"
	ms["ComboClawSlide"].desc = "Usable after using Ankle Slasher"
	ms["SwagDashAirPretty"].desc = "Consumes smoke to use. Activates Whip Combo (Doesn't benefit from it.)"
	ms["SwagDashAirPretty"].title = "Smoke Dash (Aerial)"
	ms["SwagDashAirUgly"].desc = "Consumes smoke to use."
	ms["SwagDashAirUgly"].title = "Smoke Dash (Aerial)"
	ms["SwagDashGroundPretty"].desc = "Consumes smoke to use. Activates Whip Combo (Doesn't benefit from it.)"
	ms["SwagDashGroundUgly"].desc = "Consumes smoke to use."
	ms["AirSlamClaw"].title = "Ground Slam (Aerial)"
	ms["Scissors"].title = "Scissors (Aerial)"
	ms["AirMashClaw1"].title = "Claw (Aerial)"
	
	codex.tags = ["Fire", "Quickswap", "Whip"]
	
	codex.tag_moves("Fire", ["Scorch", "AirScorch", "TorchJab", "Incinerate"])
	codex.tag_moves("Whip", ["Taunt", "WhipStrike", "WhipStrikeAir", "Whipcopter", "WhipJuggleForward"])
	
	var quickswap_frames = {
		"PointyShoe": 15,
		"WhipStrike": 11,
		"WhipStrikeAir": 11,
		"SmokeCloud": 8,
		"Pierce": 14,
		"SpinClaw": 8,
		"ClawSlide": 13,
		"ComboClawSlide": 7,
		"GroundSlam": 11,
		"GroundSlamClaw": 8,
		"AirSlamClaw": 8,
		"AirScorch": 17,
		"Scorch": 14,
		"Incinerate": 17,
		"ChargePunchDefault": 18,
		"ChargePunch2": 17,
		"ChargePunch3": 17,
		"RestandGrab": "21 (After throw)",
		"RestandGrabGroundD": "21 (After throw)",
		"WhipJuggleForward": 13,
		"Whiplash": 12,
		"LowClaw": 8,
		"AirZone": 15,
		"AerialPierce": 9,
		"IncenseMace": 14
	}
	
	for move_name in quickswap_frames:
		ms[move_name].tags.append("Quickswap")
		ms[move_name].custom_stats["Quickswap Frame"] = str(quickswap_frames[move_name])
	
