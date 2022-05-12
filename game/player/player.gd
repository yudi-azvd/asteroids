extends Area2D

var speed := 100
var velocity := Vector2.ZERO
var direction := Vector2.UP
var angular_speed := deg2rad(200)
var bullet_timer = 0
var Bullet = preload("res://game/player/bullet.tscn")

func _ready():
	$Bullet.hide()

func _process(delta):
	bullet_timer += delta
	if Input.is_action_pressed("rotate_left"):
		direction = direction.rotated(-angular_speed*delta)
	if Input.is_action_pressed("rotate_right"):
		direction = direction.rotated(angular_speed*delta)

	$AnimatedSprite.rotation = direction.rotated(PI/2).angle()
	
	if Input.is_action_pressed("accelerate"):
		velocity += direction*speed*delta
		$AnimatedSprite.animation = "moving"
	else:
		$AnimatedSprite.animation = "idle"

	if Input.is_action_pressed("shoot") and bullet_timer > 0.5:
		shoot()
			
	position += velocity*delta
	
	$Direction.text = str(int(rad2deg(direction.angle())))
	$Speed.text = str(int(velocity.length()))

	update()

func shoot():
	bullet_timer = 0
	var new_bullet = Bullet.instance()
	new_bullet.position = Vector2.ZERO
	new_bullet.rotation = direction.rotated(PI/2).angle()
	new_bullet.velocity = direction*4
	new_bullet.can_move = true
	new_bullet.show()
	add_child(new_bullet)
		
func _draw():
	var from = Vector2.ZERO
	var corrected_dir = direction.rotated(0)*25
#	draw_line(from, velocity, Color.red, 3)
#	draw_line(from, corrected_dir, Color.yellow, 3)
