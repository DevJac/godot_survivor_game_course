class_name ArenaTimeManager
extends Node


@export var end_screen_scene: PackedScene


@onready var timer = $Timer


var arena_difficulty: float:
	get:
		var result: float = get_time_elapsed() / $Timer.wait_time
		assert(0 <= result and result <= 1)
		return result


func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)


func get_time_elapsed():
	return timer.wait_time - timer.time_left


func on_timer_timeout():
	var victory_screen = end_screen_scene.instantiate()
	add_child(victory_screen)
