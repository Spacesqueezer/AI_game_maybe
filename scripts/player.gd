extends Area2D

const MIN_RADIUS = 150.0
const ORBIT_SPACING = 100.0
const ORBIT_COUNT = 4

var current_orbit_index = 0
var angle = 0.0
var speed = 2.0 # Radians per second
var direction = 1 # 1 for clockwise, -1 for counter-clockwise

func _ready():
	_update_position()
	area_entered.connect(_on_area_entered)

func _process(delta):
	angle += speed * direction * delta
	_update_position()

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		_jump()
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_jump()

func _jump():
	current_orbit_index += 1
	if current_orbit_index >= ORBIT_COUNT:
		current_orbit_index = 0
		direction *= -1 # Reverse direction on reaching the outer edge and resetting
	_update_position()

func _update_position():
	var radius = MIN_RADIUS + current_orbit_index * ORBIT_SPACING
	position = Vector2(cos(angle), sin(angle)) * radius

func _on_area_entered(area):
	if area.is_in_group("obstacles"):
		_die()
	elif area.is_in_group("coins"):
		var game = get_parent()
		if game.has_method("add_score"):
			game.add_score(1)
		area.queue_free()

func _die():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
