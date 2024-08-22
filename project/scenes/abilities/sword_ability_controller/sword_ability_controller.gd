extends Node


@export var sword_ability: PackedScene


const MAX_RANGE := 150


func _ready() -> void:
	$Timer.timeout.connect(func on_timer_timeout():
		var sword_instance: Node2D = sword_ability.instantiate()
		var enemies := get_tree().get_nodes_in_group('enemy')
		if enemies.size() == 0:
			return
		var player: Node2D = get_tree().get_first_node_in_group('player')
		var near_enemies := enemies.filter(func(e: Node2D):
			var dist_to_player := e.global_position.distance_squared_to(player.global_position)
			return dist_to_player < pow(MAX_RANGE, 2)
		)
		near_enemies.sort_custom(func(a: Node2D, b: Node2D):
			var a_dist_to_player := a.global_position.distance_squared_to(player.global_position)
			var b_dist_to_player := b.global_position.distance_squared_to(player.global_position)
			return a_dist_to_player < b_dist_to_player
		)
		if near_enemies.size() == 0:
			return
		var nearest_enemy: Node2D = near_enemies[0]
		nearest_enemy.add_sibling(sword_instance)
		sword_instance.global_position = nearest_enemy.global_position
	)
