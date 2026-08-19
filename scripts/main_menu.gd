extends Control

func _ready():
	# Connect the play button if it exists
	var play_button = $PlayButton
	if play_button:
		play_button.pressed.connect(_on_play_button_pressed)

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
