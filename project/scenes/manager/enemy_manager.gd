extends Node


@export var basic_enemy_scene: PackedScene
@export var spawn_distance: float = 400
@export var arena_time_manager: Node


func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player := get_tree().get_first_node_in_group('player')
	if not player:
		return
	var random_direction := Vector2.UP.rotated(randf_range(0, TAU))
	var new_enemy: Node2D = basic_enemy_scene.instantiate()
	new_enemy.global_position = (
		player.global_position
		+ (random_direction * spawn_distance))
	var entities_layer := get_tree().get_first_node_in_group('entities_layer')
	entities_layer.add_child(new_enemy)
	$Timer.wait_time = 1 - arena_time_manager.arena_difficulty * 0.8
	$Timer.start()
