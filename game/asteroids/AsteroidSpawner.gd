extends Node

var asteroid_spawn_timer = 0
var _asteroid_spawn_interval_in_seconds := 2
export(bool) var spawn_only_big_asteroids = true

signal asteroid_was_hit

var AsteroidBig = preload("res://game/asteroids/AsteroidBig.tscn")
var AsteroidMedium = preload("res://game/asteroids/AsteroidMedium.tscn")
var AsteroidSmall = preload("res://game/asteroids/AsteroidSmall.tscn")

onready var explosion_sound: AudioStreamPlayer = $SFXExplosion
onready var asteroidSpawnLocation = $AsteroidSpawnLocation
onready var initial = $Position2D

func _ready():
	randomize()
	spawn_asteroid(null, false)

func _process(delta):
	asteroid_spawn_timer += delta

	if asteroid_spawn_timer < _asteroid_spawn_interval_in_seconds:
		return
	
	asteroid_spawn_timer = 0
	var asteroid
	var chance = randf()
	if spawn_only_big_asteroids or chance < 0.33:
		asteroid = AsteroidBig.instance()
	elif chance < 0.66:
		asteroid = AsteroidMedium.instance()
	else:
		asteroid = AsteroidSmall.instance()
	spawn_asteroid(asteroid)
	
func spawn_asteroid(asteroid: Asteroid=null,has_direction_offset=true):
	if asteroid == null:
		asteroid = AsteroidBig.instance()
	add_child(asteroid)
	asteroidSpawnLocation.offset = randi()
	var direction_to_center = (initial.global_position - asteroidSpawnLocation.position).normalized()
	if has_direction_offset:
		direction_to_center = direction_to_center.rotated(randf()*PI/6 - PI/4)
	asteroid.init(asteroidSpawnLocation.position, direction_to_center)
	asteroid.connect('bullet_hit', self, '_on_bullet_hit')

func _on_bullet_hit(asteroid_hit: Asteroid):
	explosion_sound.play()
	if asteroid_hit.name.find('Big') > 0:
		spawn_asteroid_after_hit(AsteroidMedium.instance(), asteroid_hit)
		spawn_asteroid_after_hit(AsteroidMedium.instance(), asteroid_hit)
		emit_signal('asteroid_was_hit', 25)
	
	if asteroid_hit.name.find('Medium') > 0:
		spawn_asteroid_after_hit(AsteroidSmall.instance(), asteroid_hit)
		spawn_asteroid_after_hit(AsteroidSmall.instance(), asteroid_hit)
		emit_signal('asteroid_was_hit', 50)

	if asteroid_hit.name.find('Medium') > 0:
		emit_signal('asteroid_was_hit', 100)

func spawn_asteroid_after_hit(asteroid: Asteroid, asteroid_hit: Asteroid):
	self.call_deferred('add_child', asteroid)
	asteroid.init(asteroid_hit.position, asteroid_hit.direction.rotated(rand_range(-PI/4, PI/4)))
	asteroid.speed *= 1.1
	asteroid.connect('bullet_hit', self, '_on_bullet_hit')
