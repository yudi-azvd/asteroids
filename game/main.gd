extends Node


func _process(_delta):
	if Input.is_action_pressed("reset_position"):
		$Player.position = $Initial.position
