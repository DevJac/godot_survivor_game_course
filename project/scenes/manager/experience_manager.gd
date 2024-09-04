extends Node


signal experience_updated(current_experience: float, target_experience: float)


const TARGET_EXPERIENCE_GROWTH: int = 5


var current_level: int = 1
var current_experience: float = 0
var target_experience: int = 5


func _ready() -> void:
	GameEvents.experience_vile_collected.connect(func(number: float):
		increment_experience(number)
	)


func increment_experience(number: float) -> void:
	current_experience += number
	if current_experience >= target_experience:
		current_level += 1
		current_experience = 0
		target_experience += TARGET_EXPERIENCE_GROWTH
	experience_updated.emit(current_experience, target_experience)
