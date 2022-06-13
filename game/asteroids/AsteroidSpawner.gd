extends Node

var asteroid_spawn_timer = 0
var _asteroid_spawn_interval_in_seconds = 2

var AsteroidBig = preload("res://game/asteroids/asteroid_big.tscn")
var AsteroidMedium = preload("res://game/asteroids/asteroid_medium.tscn")

signal bullet_hit()

func _ready():
	randomize()
	connect("bullet_hit", self, 'on_bullet_hit')
	spawn_big_asteroid()

func _process(delta):
	asteroid_spawn_timer += delta

	if asteroid_spawn_timer < _asteroid_spawn_interval_in_seconds:
		return
	
	asteroid_spawn_timer = 0
	spawn_big_asteroid()
	
func spawn_big_asteroid():
	var asteroid = AsteroidBig.instance()
	add_child(asteroid)
	var asteroid_spawn_location = $AsteroidSpawnLocation
	asteroid_spawn_location.offset = randi()
	asteroid.position = asteroid_spawn_location.position
	var direction_to_center = (get_node('../Initial').position - asteroid.position).normalized()
	direction_to_center = direction_to_center.rotated(randf()*PI/6 - PI/4)
	asteroid.init(asteroid_spawn_location.position, direction_to_center)
	asteroid.connect("bullet_hit", self, '_on_bullet_hit_big')
	
func spawn_asteroid_medium(position: Vector2, direction: Vector2):
	var asteroid = AsteroidMedium.instance()
	# https://stackoverflow.com/questions/63206231/godot-3-2-1-cant-change-this-state-while-flushing-queries-use-call-deferred
	self.call_deferred('add_child', asteroid)
	asteroid.init(position, direction)
	asteroid.speed *= 2
	asteroid.connect("bullet_hit", self, '_on_bullet_hit_medium')

func _on_bullet_hit_big(area: Area2D, asteroid_hit: Asteroid):
	print(area.name + ' hit notification in spawner: ' + asteroid_hit.name)
	spawn_asteroid_medium(asteroid_hit.position, asteroid_hit.direction)
	asteroid_hit.queue_free()
	
func _on_bullet_hit_medium(area: Area2D, asteroid_hit: Asteroid):
	print(area.name + ' hit notification in spawner: ' + asteroid_hit.name)
	asteroid_hit.queue_free()
	
