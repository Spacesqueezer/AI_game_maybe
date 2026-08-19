extends Node2D

const ORBIT_COUNT = 4
const MIN_RADIUS = 150.0
const ORBIT_SPACING = 100.0

var obstacle_scene = preload("res://scenes/obstacle.tscn")

func _ready():
	_spawn_obstacles()

func _draw():
	# Draw orbits
	for i in range(ORBIT_COUNT):
		var radius = MIN_RADIUS + i * ORBIT_SPACING
		draw_arc(Vector2.ZERO, radius, 0, TAU, 64, Color(0, 1, 1, 0.2), 4.0, true)

func _spawn_obstacles():
	# Spawn a few obstacles on different orbits
	for i in range(6):
		var obs = obstacle_scene.instantiate()
		var orbit_index = randi() % ORBIT_COUNT
		var start_angle = randf() * TAU
		var dir = 1 if randf() > 0.5 else -1
		var spd = randf_range(1.0, 2.5)
		obs.setup(orbit_index, start_angle, dir, spd)
		add_child(obs)
