extends Node2D


const max_radius: float = 100


@onready var hitbox_component = $HitboxComponent
var base_rotation: float = 0


func _ready() -> void:
	base_rotation = randf_range(0, TAU)
	var tween = create_tween()
	tween.tween_method(tween_axe_revolutions, 0.0, 2.0, 3.0)
	tween.tween_callback(free)


func tween_axe_revolutions(r: float):
	var player = get_tree().get_first_node_in_group('player')
	if not player:
		free()
		return
	var current_radius = (r / 2.0) * max_radius
	var current_direction = Vector2.RIGHT.rotated(r * TAU + base_rotation)
	global_position = (
		player.global_position
		+ current_direction.normalized() * current_radius)
