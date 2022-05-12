extends Area2D

var touch_limit_count = 0
var speed = 200
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

	print(position)
	print("touch limit ", area.name)
	touch_limit_count += 1
	if area.name.ends_with("Top"):
		position.y = window_height/2
	if area.name.ends_with("Bottom"):
		position.y = -window_height/2
	if area.name.ends_with("Right"):
		position.x = -window_width/2
	if area.name.ends_with("Left"):
		position.x = window_width/2
	print(position)
		
	if touch_limit_count == 2:
		print("free bullet")
		queue_free()

func _on_Bullet_shoot_bullet():
  can_move = true
