extends Area2D

class_name Asteroid

onready var window_height := get_viewport().size.y
onready var window_width := get_viewport().size.x

signal bullet_hit(asteroid)

var limit_touch_count := 0
var teleport_count := 0
var speed = 50
var direction = Vector2.UP

func _ready() -> void:
# warning-ignore:return_value_discarded
	connect('area_entered', self, '_on_Asteroid_area_entered')

func _init():
	linear_damp = 0

func _process(delta):
	position += speed*direction*delta
	teleport_if_on_edge()
	
func init(position: Vector2, direction_: Vector2):
	rotation = randf() * 2 * PI
	global_position = position
	direction = direction_
	linear_damp = 0
	show()
	
func teleport_if_on_edge():
#	if teleport_count > 1:
#		queue_free(); return
#
#	if global_position.x > window_width:
#		teleport_count += 1
#		global_position.x = 0
#	if global_position.x < 0:
#		teleport_count += 1
#		global_position.x = window_width
#	if global_position.y > window_height:
#		teleport_count += 1
#		global_position.y = 0
#	if global_position.y < 0:
#		teleport_count += 1
#		global_position.y = window_height
	pass
	
func _on_Asteroid_area_entered(area: Area2D) -> void:
#	if area.name.begins_with('@Bullet'):
	if area is Bullet:
		emit_signal('bullet_hit', self)
#		print(area.name + ' entered ' + name)
		queue_free()

	if area.name.begins_with("Limit"):
#		print(name + ' touched ' + area.name)
		queue_free()
