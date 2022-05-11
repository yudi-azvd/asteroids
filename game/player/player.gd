extends Area2D

var speed := 0
var velocity := Vector2.RIGHT
var direction := Vector2.UP
var angular_speed := deg2rad(50)
var speed_x := 2
var speed_y := 2

func _ready():
#	$AnimatedSprite.rotation = direction.angle()
	pass

func _process(delta):
	update()
	var dx = 0
	var dy = 0
	if Input.is_action_pressed("rotate_left"):
		direction = direction.rotated(-angular_speed*delta)
	if Input.is_action_pressed("rotate_right"):
		direction = direction.rotated(angular_speed*delta)

#	$AnimatedSprite.rotation = direction.angle()
	
	if velocity.length() < 500:
		velocity += velocity*velocity.dot(direction)
	if Input.is_action_pressed("accelerate"):
		position += velocity*speed*delta
	
	velocity = velocity.normalized()*clamp(velocity.length(), 0, 50)
	
	$Direction.text = str(rad2deg(direction.angle()))
	
func _draw():
	var from = Vector2.ZERO
	var corrected_dir = direction.rotated(0)*25
	draw_line(from, velocity*100, Color.red, 3)
	draw_line(from, corrected_dir, Color.yellow, 3)
