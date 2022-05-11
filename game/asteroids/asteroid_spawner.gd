extends Node

var local_delta = 0
export(PackedScene) var asteroid_big_scene

func _process(delta):
	local_delta += delta
	# if local_delta < 1.5:
	# 	return
	
	# var asteroid = asteroid_big_scene.instance()
	# add_child(asteroid)
	# print("spawn asteroid")
	# asteroid.position = Vector2(200, 200)
	# asteroid.linear_velocity = Vector2(100, 0)
	
	# local_delta = 0
