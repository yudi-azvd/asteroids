extends Node

var AsteroidSpawner = preload("res://game/asteroids/AsteroidSpawner.gd")

func _ready():
#	$AsteroidSpawner._asteroid_spawn_interval_in_seconds = INF
	$AsteroidSpawner/SFXExplosion.stop()
	pass

func on_Player_died():
	print('Player died')
