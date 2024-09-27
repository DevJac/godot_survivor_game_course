extends Node


@export_range(0, 1) var drop_percent: float = 0.5
@export var health_component: HealthComponent
@export var vile_scene: PackedScene


func _ready() -> void:
	health_component.died.connect(on_died)


func on_died():
	if randf() > drop_percent:
		var vile_instance: Node2D = vile_scene.instantiate()
		var entities_layer := (
			get_tree().get_first_node_in_group('entities_layer'))
		Callable(entities_layer.add_child).call_deferred(vile_instance)
		vile_instance.global_position = owner.global_position
