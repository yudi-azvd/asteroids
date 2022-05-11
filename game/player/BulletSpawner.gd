extends Node

var bullet_timer = 0
export(PackedScene) var bullet_scene

func _process(delta):
	bullet_timer += delta
	# var ship_direction = get_parent().direction
	var ship_direction = $"../AnimatedSprite.direction"
	
	if Input.is_action_pressed("shoot") and bullet_timer > 0.3:
		emit_signal("shoot_bullet", ship_direction*4)
		
		bullet_timer = 0
		var bullet = bullet_scene.instance()
		bullet.position = Vector2.ZERO
		bullet.modulate.a = 1
		bullet.rotation = ship_direction.rotated(PI/2).angle()
		bullet.velocity = ship_direction*4
		add_child(bullet)
