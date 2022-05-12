extends Area2D

var touch_limit_count = 0
var speed = 50
var velocity = Vector2.UP*4
var can_move = false
onready var window_height = get_viewport().size.y
onready var window_width = get_viewport().size.x

func _process(dt):
	if can_move:
		position += velocity*dt*speed

func _on_Bullet_area_entered(area: Area2D):
	if not area.name.begins_with("Limit"):
		return

	touch_limit_count += 1
	if area.name.ends_with("Top"):
		global_position.y = window_height
	if area.name.ends_with("Bottom"):
		global_position.y = 0
	if area.name.ends_with("Right"):
		global_position.x = 0
	if area.name.ends_with("Left"):
		global_position.x = window_width
	
	if touch_limit_count == 2:
		queue_free()

func _on_Bullet_shoot_bullet():
  can_move = true
