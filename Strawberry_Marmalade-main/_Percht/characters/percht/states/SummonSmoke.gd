extends "res://Strawberry_Marmalade-main/_Percht/PerchtMove.gd"

var PROJ_SCENE = preload("res://Strawberry_Marmalade-main/_Percht/characters/percht/projectiles/Smoke.tscn")
var number = 10
var span = 55 * 10

func _frame_1():
	print(host.smoke_projectiles)
	for smoke in host.smoke_projectiles:
		host.objs_map[smoke].smokescreen_disable()

func _frame_6():
	for i in range(number):
		var smoke_y = -20
		var smoke_x = -span/2 + (span / number * (i+0.5))
		
		var smoke = host.spawn_object(PROJ_SCENE, smoke_x, smoke_y, true)
		host.smoke_projectiles.append(smoke.obj_name)
		smoke.smokescreen = true
