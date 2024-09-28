extends CharacterBody2D


const MAX_SPEED = 125
const ACCELERATION_SMOOTHING = 25


var num_colliding_bodies: int = 0


const MOVEMENTS = {
	'move_left': Vector2(-1, 0),
	'move_right': Vector2(1, 0),
	'move_up': Vector2(0, -1),
	'move_down': Vector2(0, 1),
}


func _assert_valid_movements():
	for movement in MOVEMENTS:
		Input.get_action_strength(movement)
	return true


func _ready():
	assert(_assert_valid_movements())
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	$DamagerIntervalTimer.timeout.connect(check_deal_damage)


func _process(delta: float) -> void:
	var target_velocity := get_movement_direction() * MAX_SPEED
	velocity = velocity.lerp(
		target_velocity,
		1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()


func get_movement_direction() -> Vector2:
	var integrated_movement = Vector2.ZERO
	for movement in MOVEMENTS:
		integrated_movement += (
			Input.get_action_strength(movement) * MOVEMENTS[movement])
	if integrated_movement.length_squared() > 1:
		integrated_movement = integrated_movement.normalized()
	return integrated_movement


func check_deal_damage():
	if num_colliding_bodies == 0 or not $DamagerIntervalTimer.is_stopped():
		return
	$HealthComponent.damage(1)
	$DamagerIntervalTimer.start()
	prints('Player health:', $HealthComponent.current_health)


func on_body_entered(_body: Node2D) -> void:
	num_colliding_bodies += 1
	check_deal_damage()


func on_body_exited(_body: Node2D) -> void:
	num_colliding_bodies -= 1
