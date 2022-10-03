extends Node

var AsteroidSpawner = preload("res://game/asteroids/AsteroidSpawner.gd")
onready var player = $Player
onready var hud = $CanvasLayer/HUD
onready var asteroidSpawner = $AsteroidSpawner

func _ready():
	asteroidSpawner.get_node('SFXExplosion').stop()
	asteroidSpawner.connect('asteroid_was_hit', hud, 'on_asteroid_was_hit')
	player.connect("player_died", self, "on_Player_died")
	player.connect('player_was_hit', hud, 'on_Player_was_hit')
	

func on_Player_died():
	print('Player died')
