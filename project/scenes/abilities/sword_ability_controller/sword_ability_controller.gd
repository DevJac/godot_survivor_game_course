extends Node


@export var sword_ability: PackedScene


var damage = 5
var base_wait_time: float
const MAX_RANGE := 150


func _ready() -> void:
	base_wait_time = $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func rand_triangle_index(high: int) -> int:
	return int(floor(min(randf(), randf()) * float(high)))


func on_timer_timeout():
	var enemies := get_tree().get_nodes_in_group('enemy')
	if enemies.size() == 0:
		return
	var player: Node2D = get_tree().get_first_node_in_group('player')
	var near_enemies := enemies.filter(func(e: Node2D):
		var dist_to_player := e.global_position.distance_squared_to(player.global_position)
		return dist_to_player < pow(MAX_RANGE, 2)
	)
	near_enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_dist_to_player := a.global_position.distance_squared_to(player.global_position)
		var b_dist_to_player := b.global_position.distance_squared_to(player.global_position)
		return a_dist_to_player < b_dist_to_player
	)
	if near_enemies.size() == 0:
		return
	var nearest_enemy: Node2D = (
		near_enemies[rand_triangle_index(near_enemies.size())])
	var sword_instance: SwordAbility = sword_ability.instantiate()
	var foreground_layer := (
		get_tree().get_first_node_in_group('foreground_layer'))
	foreground_layer.add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage
	sword_instance.global_position = nearest_enemy.global_position
	var player_to_enemy := nearest_enemy.global_position - player.global_position
	sword_instance.rotation = player_to_enemy.angle()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id != "sword_rate":
		return
	assert(upgrade.id == "sword_rate")
	var percent_reduction = current_upgrades["sword_rate"]['quantity'] * 0.1
	$Timer.wait_time = max(0.1, base_wait_time * (1 - percent_reduction))
	$Timer.start()
