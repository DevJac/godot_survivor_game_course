extends CharacterBody2D


const MAX_SPEED = 200 * 60


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


func _process(delta: float) -> void:
	velocity = get_movement_vector() * MAX_SPEED * delta
	move_and_slide()


func get_movement_vector() -> Vector2:
	var integrated_movement = Vector2.ZERO
	for movement in MOVEMENTS:
		if Input.get_action_strength(movement):
			integrated_movement += MOVEMENTS[movement]
	if not integrated_movement.is_zero_approx():
		integrated_movement = integrated_movement.normalized()
	return integrated_movement
