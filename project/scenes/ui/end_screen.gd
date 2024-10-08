extends CanvasLayer


func _ready() -> void:
	get_tree().paused = true
	%RestartButton.pressed.connect(on_restart_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)


func set_defeat():
	%Label.text = 'Defeat'
	%Label2.text = 'You lost!'


func on_restart_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file('res://scenes/main/main.tscn')


func on_quit_pressed():
	get_tree().quit()
