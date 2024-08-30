extends CharacterBody2D


const MAX_SPEED = 200


const MOVEMENTS = {
	'move_left': Vector2(-1, 0),
	'move_right': Vector2(1, 0),
	'move_up': Vector2(0, -1),
	'move_down': Vector2(0, 1),
}


func _ready():
	assert(func():
		# Ensure the movements defined here match those in the input map.
		for movement in MOVEMENTS:
			Input.get_action_strength(movement)
		return true)


func _process(_delta: float) -> void:
	velocity = get_movement_direction() * MAX_SPEED
	move_and_slide()


func get_movement_direction() -> Vector2:
	var integrated_movement = Vector2.ZERO
	for movement in MOVEMENTS:
		integrated_movement += (
			Input.get_action_strength(movement) * MOVEMENTS[movement])
	if integrated_movement > 1:
		integrated_movement = integrated_movement.normalized()
	return integrated_movement
