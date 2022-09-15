extends Node

var asteroid_spawn_timer = 0
var _asteroid_spawn_interval_in_seconds := 2

var AsteroidBig = preload("res://game/asteroids/AsteroidBig.tscn")
var AsteroidMedium = preload("res://game/asteroids/AsteroidMedium.tscn")
var AsteroidSmall = preload("res://game/asteroids/AsteroidSmall.tscn")

onready var explosion_sound: AudioStreamPlayer = $SFXExplosion
onready var playerInitialPosition = get_node('../Initial')
onready var asteroidSpawnLocation = $AsteroidSpawnLocation
onready var initial = get_node('../Initial')

func _ready():
	randomize()
	spawn_big_asteroid(false)

func _process(delta):
	asteroid_spawn_timer += delta

	if asteroid_spawn_timer < _asteroid_spawn_interval_in_seconds:
		return
	
	asteroid_spawn_timer = 0
	spawn_big_asteroid()
	
func spawn_big_asteroid(has_direction_offset=true):
	var asteroid = AsteroidBig.instance()
	add_child(asteroid)
	asteroidSpawnLocation.offset = randi()
	var direction_to_center = (get_node('../Initial').global_position - asteroidSpawnLocation.position).normalized()
	if has_direction_offset:
		direction_to_center = direction_to_center.rotated(randf()*PI/6 - PI/4)
	asteroid.init(asteroidSpawnLocation.position, direction_to_center)
	asteroid.connect('bullet_hit', self, '_on_bullet_hit')

func _on_bullet_hit(asteroid_hit: Asteroid):
	explosion_sound.play()
	if asteroid_hit.name.find('Big') > 0:
		spawn_asteroid(AsteroidMedium.instance(), asteroid_hit)
		spawn_asteroid(AsteroidMedium.instance(), asteroid_hit)
	
	if asteroid_hit.name.find('Medium') > 0:
		spawn_asteroid(AsteroidSmall.instance(), asteroid_hit)
		spawn_asteroid(AsteroidSmall.instance(), asteroid_hit)

func spawn_asteroid(asteroid: Asteroid, asteroid_hit: Asteroid):
	self.call_deferred('add_child', asteroid)
	asteroid.init(asteroid_hit.position, asteroid_hit.direction.rotated(rand_range(-PI/4, PI/4)))
	asteroid.speed *= 1.1
	asteroid.connect('bullet_hit', self, '_on_bullet_hit')
