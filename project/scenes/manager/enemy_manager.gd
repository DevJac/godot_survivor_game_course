extends Node


@export var basic_enemy_scene: PackedScene
@export var spawn_distance: float = 400
@export var arena_time_manager: ArenaTimeManager


@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)


func on_timer_timeout() -> void:
	var player: Node2D = get_tree().get_first_node_in_group('player')
	if not player:
		return
	var new_enemy: Node2D = basic_enemy_scene.instantiate()
	new_enemy.global_position = find_empty_spawn_location(player)
	var entities_layer: Node2D = (
		get_tree().get_first_node_in_group('entities_layer'))
	entities_layer.add_child(new_enemy)
	timer.wait_time = 1 - arena_time_manager.arena_difficulty * 0.8
	timer.start()


func find_empty_spawn_location(player: Node2D) -> Vector2:
	## Returns a Vector2 as long as arena is large enough
	var random_rotation: float = randf_range(0, TAU / 4)
	var directions: Array[Vector2] = [
		Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
	directions.shuffle()
	for direction in directions:
		var candidate_spawn_position := (
			player.global_position
			+ direction.rotated(random_rotation)
			* spawn_distance)
		var query := PhysicsPointQueryParameters2D.new()
		query.collision_mask = 1
		query.position = candidate_spawn_position
		var point_intersections := (
			get_tree().root.world_2d.direct_space_state.intersect_point(query))
		if point_intersections.is_empty():
			return candidate_spawn_position
	assert(false, "couldn't find empty spawn position for enemy")
	return player.global_position
