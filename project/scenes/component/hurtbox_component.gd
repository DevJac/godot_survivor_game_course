extends Area2D
class_name HurtboxComponent


@export var health_component: HealthComponent


func _ready():
	area_entered.connect(func(other_area: Area2D):
		if other_area is not HitboxComponent:
			return
		var hitbox_component: HitboxComponent = other_area
		health_component.damage(hitbox_component.damage)
	)
