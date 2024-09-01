extends CanvasLayer


@export var arena_time_manager: Node
@onready var label: Label = %Label


func _process(delta: float) -> void:
	var time_elapsed: float = arena_time_manager.get_time_elapsed()
	label.text = '%01d:%02d' % [minutes(time_elapsed), seconds(time_elapsed)]


func minutes(time_elapsed: float) -> float:
	return floor(time_elapsed / 60)


func seconds(time_elapsed: float) -> float:
	return floor(fmod(time_elapsed, 60))
