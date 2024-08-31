extends Node


@export var basic_enemy_scene: PackedScene
@export var spawn_distance: float = 400


func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	print('spawn enemy')
	var player := get_tree().get_first_node_in_group('player')
	if not player:
		return
	var random_direction := Vector2.UP.rotated(randf_range(0, TAU))
	var new_enemy: Node2D = basic_enemy_scene.instantiate()
	new_enemy.global_position = (
		player.global_position
		+ (random_direction * spawn_distance))
	add_child(new_enemy)
	
