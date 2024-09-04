extends CanvasLayer


@export var experience_manager: Node


func _ready() -> void:
	experience_manager.connect('experience_updated', on_experience_updated)


func on_experience_updated(current_experience: float, target_experience: float):
	$MarginContainer/ProgressBar.value = current_experience / target_experience
