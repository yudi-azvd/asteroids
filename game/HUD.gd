extends Control

onready var timer = $BlinkTimer
onready var pointsLabel = $Points
onready var gameTimer = $GameTimer
onready var ship = $Ship
onready var animationPlayer = $AnimationPlayer

var player_points = 0
var time_elapsed = 0.0
var player_life_points = 3

const SHIP_WIDTH = 49

func _ready() -> void:
	ship.rect_size.x = player_life_points*SHIP_WIDTH
	gameTimer.start()

	
func on_asteroid_was_hit(points: int):
	player_points += points
	pointsLabel.text = var2str(player_points)

func on_Player_was_hit():
	player_life_points -= 1
	
	if player_life_points == 0:
		animationPlayer.stop()
		ship.hide()
	else:
		ship.rect_size.x = player_life_points*SHIP_WIDTH
		animationPlayer.play('blink')
		timer.start()


func _on_Timer_timeout() -> void:
	animationPlayer.stop()
