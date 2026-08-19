extends Node2D

const ORBIT_COUNT = 4
const MIN_RADIUS = 150.0
const ORBIT_SPACING = 100.0

func _draw():
	# Draw orbits
	for i in range(ORBIT_COUNT):
		var radius = MIN_RADIUS + i * ORBIT_SPACING
		draw_arc(Vector2.ZERO, radius, 0, TAU, 64, Color(0, 1, 1, 0.2), 4.0, true)
