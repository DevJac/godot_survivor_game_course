extends Node

@export var axe_ability_scene: PackedScene


var damage = 10


func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player: Player = get_tree().get_first_node_in_group('player')
	var axe_instance: Node2D = axe_ability_scene.instantiate()
	var foreground: Node2D = get_tree().get_first_node_in_group('foreground_layer')
	foreground.add_child(axe_instance)
	axe_instance.hitbox_component.damage = damage
	axe_instance.global_position = player.global_position
