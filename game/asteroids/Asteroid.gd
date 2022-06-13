extends Area2D

class_name Asteroid

onready var window_height := get_viewport().size.y
onready var window_width := get_viewport().size.x
onready var asteroid_spawner = get_node("../../AsteroidSpawner")

signal bullet_hit

var speed = 50
var direction = Vector2.UP

func _init():
	linear_damp = 0

func _process(delta):
	position += speed*direction*delta
	teleport_if_on_edge()
	
func init(position: Vector2, direction_: Vector2):
	connect("area_entered", self, '_on_area_entered')
	global_position = position
	direction = direction_
	linear_damp = 0
	show()
	
func teleport_if_on_edge():
	if global_position.x > window_width:
		global_position.x = 0
	if global_position.x < 0:
		global_position.x = window_width
	if global_position.y > window_height:
		global_position.y = 0
	if global_position.y < 0:
		global_position.y = window_height
	
func _on_area_entered(area: Area2D):
	if area.name.to_lower().find('bullet') > 0:
		print(area.name + ' entered ' + name + ' !')
		emit_signal("bullet_hit", area, self)
		
