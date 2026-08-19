extends Area2D

const MIN_RADIUS = 100.0
const ORBIT_SPACING = 80.0
const ORBIT_COUNT = 4

var current_orbit_index = 0
var target_orbit_index = 0
var current_radius = 100.0

var angle = 0.0
var speed = 2.0 # Radians per second
var angular_direction = 1 # 1 for clockwise, -1 for counter-clockwise
var radial_direction = 1 # 1 for moving outward, -1 for moving inward

var is_jumping = false
var jump_tween: Tween

func _ready():
	current_radius = MIN_RADIUS
	_update_position()
	area_entered.connect(_on_area_entered)

func _process(delta):
	angle += speed * angular_direction * delta
	_update_position()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_jump()
	elif event is InputEventScreenTouch and event.pressed:
		pass # Assuming emulated touch from mouse handles it

func _jump():
	if is_jumping:
		return # Prevent jumping while already jumping

	is_jumping = true
	target_orbit_index = current_orbit_index + radial_direction

	# Bounce back if we hit the edges
	if target_orbit_index >= ORBIT_COUNT:
		target_orbit_index = ORBIT_COUNT - 2
		radial_direction = -1
		angular_direction *= -1
	elif target_orbit_index < 0:
		target_orbit_index = 1
		radial_direction = 1
		angular_direction *= -1

	current_orbit_index = target_orbit_index
	var target_radius = MIN_RADIUS + target_orbit_index * ORBIT_SPACING

	# Use Tween for smooth transition
	if jump_tween:
		jump_tween.kill() # Kill existing tween if any
	jump_tween = get_tree().create_tween()
	jump_tween.tween_property(self, "current_radius", target_radius, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	jump_tween.tween_callback(func(): is_jumping = false)

func _update_position():
	position = Vector2(cos(angle), sin(angle)) * current_radius

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
