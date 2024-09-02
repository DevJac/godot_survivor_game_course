extends Node


var current_experience: float = 0


func _ready() -> void:
	GameEvents.experience_vile_collected.connect(func(number: float):
		increment_experience(number)
	)


func increment_experience(number: float) -> void:
	current_experience += number
	print('Current Experience: %d' % current_experience)
