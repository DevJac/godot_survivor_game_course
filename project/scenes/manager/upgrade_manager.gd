extends Node


@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene


var current_upgrades = {}


func _ready() -> void:
	experience_manager.level_up.connect(on_level_up)


func apply_upgrade(upgrade: AbilityUpgrade):
	if not current_upgrades.has(upgrade.id):
		current_upgrades[upgrade.id] = {
			'resource': upgrade,
			'quantity': 1}
	else:
		current_upgrades[upgrade.id]['quantity'] += 1
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)
	print_debug(current_upgrades)


func get_current_upgrade_quantity(upgrade: AbilityUpgrade) -> int:
	if upgrade.id in current_upgrades:
		return current_upgrades[upgrade.id]['quantity']
	else:
		return 0


func pick_upgrades() -> Array[AbilityUpgrade]:
	var filtered_upgrades := upgrade_pool.duplicate()
	filtered_upgrades = filtered_upgrades.filter(func (upgrade: AbilityUpgrade):
		var quantity_available: bool = (
			get_current_upgrade_quantity(upgrade) < upgrade.max_quantity)
		return quantity_available
	)
	filtered_upgrades.shuffle()
	return filtered_upgrades.slice(0, 1000)


func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)


func on_level_up(_current_level: int):
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	var upgrades := pick_upgrades()
	if upgrades.size() == 0:
		return
	upgrade_screen_instance.set_ability_upgrades(upgrades)
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
