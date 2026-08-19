extends Area2D

const MIN_RADIUS = 100.0
const ORBIT_SPACING = 80.0

var orbit_index = 0
var angle = 0.0
var speed = 1.5 # Radians per second
var direction = 1 # 1 for clockwise, -1 for counter-clockwise

func _ready():
	_update_position()
	# Add to group so player can identify it easily
	add_to_group("obstacles")

func setup(index: int, start_angle: float, dir: int, spd: float):
	orbit_index = index
	angle = start_angle
	direction = dir
	speed = spd
	_update_position()

func _process(delta):
	angle += speed * direction * delta
	_update_position()

func _update_position():
	var radius = MIN_RADIUS + orbit_index * ORBIT_SPACING
	position = Vector2(cos(angle), sin(angle)) * radius
