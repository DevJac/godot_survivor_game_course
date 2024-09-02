extends Node2D


func _ready() -> void:
	$Area2D.connect('area_entered', pickup_area_entered)


func pickup_area_entered(_other_area: Area2D):
	GameEvents.emit_experience_vile_collected(1)
	queue_free()
