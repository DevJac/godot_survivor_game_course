extends Node


@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene


var current_upgrades = {}


func _ready() -> void:
	experience_manager.level_up.connect(on_level_up)


func on_level_up(_current_level: int):
	var chosen_upgrade: AbilityUpgrade = upgrade_pool.pick_random()
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades([chosen_upgrade] as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)


func apply_upgrade(upgrade: AbilityUpgrade):
	if not current_upgrades.has(upgrade.id):
		current_upgrades[upgrade.id] = {
			'resource': upgrade,
			'quantity': 1}
	else:
		current_upgrades[upgrade.id]['quantity'] += 1
	print_debug(current_upgrades)


func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)
