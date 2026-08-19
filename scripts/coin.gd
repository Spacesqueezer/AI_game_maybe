extends Area2D

const MIN_RADIUS = 100.0
const ORBIT_SPACING = 80.0

var orbit_index = 0
var angle = 0.0

func _ready():
	add_to_group("coins")
	_update_position()

func setup(index: int, start_angle: float):
	orbit_index = index
	angle = start_angle
	_update_position()

func _process(delta):
	$Visual.rotation += 2.0 * delta

func _update_position():
	var radius = MIN_RADIUS + orbit_index * ORBIT_SPACING
	position = Vector2(cos(angle), sin(angle)) * radius
