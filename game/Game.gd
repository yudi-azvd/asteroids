extends Node

var AsteroidSpawner = preload("res://game/asteroids/AsteroidSpawner.gd")
onready var player = $Player
onready var hud = $CanvasLayer/HUD
onready var asteroidSpawner = $AsteroidSpawner
onready var gameOverScreen = $CanvasLayer/GameOverScreen

func _ready():
	player.connect("player_died", self, "on_Player_died")
	player.connect('player_was_hit', hud, 'on_Player_was_hit')
	asteroidSpawner.connect('asteroid_was_hit', hud, 'on_asteroid_was_hit')
	gameOverScreen.hide()


func on_Player_died():
	gameOverScreen.show()
	var text = 'YOU MADE\n' + hud.pointsLabel.text + ' POINTS'
	gameOverScreen.get_node('Points').text = text
	print('Player died')


func _on_PlayAgain_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene('res://game/Game.tscn')
	

func _on_QuitToMenu_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene('res://ui/TitleScreen.tscn')
