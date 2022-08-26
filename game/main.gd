extends Node

var AsteroidSpawner = preload("res://game/asteroids/AsteroidSpawner.gd")

func _ready():
	$Player.connect("player_died", self, "on_Player_died")
#	$AsteroidSpawner._asteroid_spawn_interval_in_seconds = INF
	$AsteroidSpawner/SFXExplosion.stop()
	

func on_Player_died():
	print('Player died')
