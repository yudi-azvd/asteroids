extends Area2D

class_name Bullet 

var touch_limit_count = 0
var speed = 100
var velocity = Vector2.UP*4
var can_move = false
onready var window_height = get_viewport().size.y
onready var window_width = get_viewport().size.x

func _ready():
	connect('body_entered', self, '_on_body_entered')

func _process(dt):
	if can_move:
		position += velocity*dt*speed

func _on_Bullet_area_entered(area: Area2D):
	if area.name.find('Asteroid') > 0:
		self.collision_layer = 0
		
		set_deferred('CollisionShape2D.disabled', true)
#		$CollisionShape2D.disabled = true
		queue_free()
	
	if area.name.begins_with('Limit'):
		queue_free()


func _on_Bullet_shoot_bullet():
  can_move = true
