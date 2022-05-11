extends Area2D

var speed := 100
var velocity := Vector2.ZERO
var direction := Vector2.UP
var angular_speed := deg2rad(100)
var speed_x := 2
var speed_y := 2

func _ready():
#	$AnimatedSprite.rotation = direction.angle()
	pass

func _process(delta):
	update()
	if Input.is_action_pressed("rotate_left"):
		direction = direction.rotated(-angular_speed*delta)
	if Input.is_action_pressed("rotate_right"):
		direction = direction.rotated(angular_speed*delta)

	$AnimatedSprite.rotation = direction.rotated(PI/2).angle()
	
	if Input.is_action_pressed("accelerate"):
		velocity += direction*speed*delta
	
	position.x += velocity.x*delta
	position.y += velocity.y*delta
	
	$Direction.text = str(int(rad2deg(direction.angle())))
	$Direction.text += '\n' + str(int(rad2deg($AnimatedSprite.rotation)))
	$Speed.text = str(int(velocity.length()))
	
func _draw():
	var from = Vector2.ZERO
	var corrected_dir = direction.rotated(0)*25
	draw_line(from, velocity, Color.red, 3)
	draw_line(from, corrected_dir, Color.yellow, 3)
