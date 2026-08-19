extends Area2D

const MIN_RADIUS = 150.0
const ORBIT_SPACING = 100.0

var orbit_index = 0
var angle = 0.0

func _ready():
	add_to_group("coins")
	_update_position()

func setup(index: int, start_angle: float):
	orbit_index = index
	angle = start_angle
	_update_position()

func _update_position():
	var radius = MIN_RADIUS + orbit_index * ORBIT_SPACING
	position = Vector2(cos(angle), sin(angle)) * radius
