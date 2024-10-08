extends Node


@export var end_screen_scene: PackedScene


func _ready() -> void:
	var player: Player = %Player
	player.died.connect(on_player_died)


func on_player_died():
	var defeat_screen = end_screen_scene.instantiate()
	add_child(defeat_screen)
	defeat_screen.set_defeat()
