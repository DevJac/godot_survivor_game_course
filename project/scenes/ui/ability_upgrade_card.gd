extends Panel


signal selected


@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel


var just_left_clicked = false


func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func _gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed('left_click'):
		just_left_clicked = true
	if Input.is_action_just_released('left_click'):
		if Rect2(Vector2.ZERO, size).has_point(event.position):
			selected.emit()
		just_left_clicked = false
