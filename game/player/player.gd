extends Area2D

var speed := 300
var velocity := Vector2.ZERO
var direction := Vector2.UP
var angular_speed := deg2rad(200)
var bullet_timer = 0
var Bullet = preload("res://game/player/bullet.tscn")
const MAX_VELOCITY = 400
onready var window_height = get_viewport().size.y
onready var window_width = get_viewport().size.x



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
		if velocity.length() < MAX_VELOCITY or velocity.dot(direction) < -1:
			velocity += direction*speed*delta
			$AnimatedSprite.animation = "moving"
	else:
		$AnimatedSprite.animation = "idle"

	if Input.is_action_pressed("shoot") and bullet_timer > 0.5:
		shoot()
	
	position += velocity*delta
	
	$Direction.text = str(int(rad2deg(direction.angle())))
	$Velocity.text = str(int(velocity.length()))

	teletransport_if_on_edge()
	update()

func teletransport_if_on_edge():
	if position.x > window_width:
		position.x = 0
	if position.x < 0:
		position.x = window_width
	if position.y > window_height:
		position.y = 0
	if position.y < 0:
		position.y = window_height

func shoot():
	bullet_timer = 0
	var new_bullet = Bullet.instance()
	new_bullet.position = Vector2.ZERO
	new_bullet.rotation = direction.rotated(PI/2).angle()
	new_bullet.velocity = direction*4
	new_bullet.can_move = true
	new_bullet.show()
	add_child(new_bullet)
		
# func _draw():
# 	var from = Vector2.ZERO
# 	var corrected_dir = direction.rotated(0)*25
# 	draw_line(from, velocity, Color.red, 3)
# 	draw_line(from, corrected_dir, Color.yellow, 3)
