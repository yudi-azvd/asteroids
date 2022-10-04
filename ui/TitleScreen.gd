extends Control

var game = preload('res://game/Game.tscn')
onready var playButton = $Play

func _ready() -> void:
	randomize()

func _on_Play_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(game)
