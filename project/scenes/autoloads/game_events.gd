extends Node


signal experience_vile_collected(number: float)


func emit_experience_vile_collected(number: float):
	experience_vile_collected.emit(number)
