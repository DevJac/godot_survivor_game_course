extends Node


@export var sword_ability: PackedScene


func _ready() -> void:
	$Timer.timeout.connect(func on_timer_timeout():
		var sword_instance: Node2D = sword_ability.instantiate()
		var player: Node2D = get_tree().get_first_node_in_group('player')
		player.add_sibling(sword_instance)
		sword_instance.global_position = player.global_position
	)
