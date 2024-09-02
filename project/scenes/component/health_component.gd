extends Node
class_name HealthComponent


signal died


@export var max_health: float = 10
var current_health: float


func _ready() -> void:
	current_health = max_health


func damage(damage_amount: float) -> void:
	current_health = max(0, current_health - damage_amount)
	if current_health == 0:
		died.emit()
		Callable(owner.queue_free).call_deferred()
