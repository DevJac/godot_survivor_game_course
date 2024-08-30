extends CharacterBody2D


const MAX_SPEED = 75


func _ready() -> void:
	$HitBox.area_entered.connect(func(_area: Area2D):
		queue_free()
	)


func _process(_delta: float) -> void:
	var to_player := vector_to_player()
	if to_player.length_squared() > 1000:
		velocity = to_player.normalized() * MAX_SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()


func vector_to_player() -> Vector2:
	var player_nodes := get_tree().get_nodes_in_group('player')
	assert(player_nodes.size() == 1)
	var player: Node2D = player_nodes[0]
	return player.global_position - global_position
