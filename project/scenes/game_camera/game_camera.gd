extends Camera2D


func _process(delta: float) -> void:
	var player_nodes = get_tree().get_nodes_in_group('player')
	assert(player_nodes.size() == 1)
	var player: Node2D = player_nodes[0]
	global_position = global_position.lerp(
		player.global_position,
		1 - exp(-delta * 10))
