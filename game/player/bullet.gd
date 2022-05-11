extends Area2D

signal shoot_bullet

var touch_limit_count = 0
var speed = 200
var velocity = Vector2.UP*4
var can_move = false

func _process(dt):
	position += velocity*dt*speed
#	print(position)

func _on_Bullet_area_entered(area: Area2D):
	if not area.name.begins_with("Limit"):
		return

	print("touched limit ", area.name)
	touch_limit_count += 1
	
	print("pos y ", position.y)
	if area.name.ends_with("Top"):
#		position.y = get_viewport().size.y/2 +100
		pass
	if area.name.ends_with("Bottom"):
		position.y = -get_viewport().size.y/2

	if touch_limit_count == 2:
		print("free bullet")
		queue_free()


func _on_Bullet_shoot_bullet():
	pass # Replace with function body.
