class_name PlayerUpgrader extends Node

@onready var parent: Player = get_parent()
@onready var weapon: WeaponBase = parent.get_node("Hand/Sprite2D").get_child(0)

func upgrade_health(amount: float) -> void:
	parent.max_health += amount
	parent.current_health = parent.current_health
	parent.set_bars()

func upgrade_speed(amount: float) -> void:
	parent.max_speed += amount

func upgrade_dodge_cooldown(amount: float) -> void:
	parent.dodge_cooldown -= amount
	parent.set_bars()

func upgrade_dodge(amount: float) -> void:
	parent.dodge_speed_multiplier += amount
	parent.dodge_time += 0.1

func upgrade_weapon_spread(amount: float) -> void:
	weapon.upgrade_weapon_spread(amount)

func upgrade_weapon_damage(amount: float) -> void:
	weapon.upgrade_weapon_damage(amount)

func upgrade_projectile_speed(amount: float) -> void:
	weapon.upgrade_projectile_speed(amount)

func upgrade_weapon_firerate(amount: float) -> void:
	weapon.upgrade_weapon_firerate(amount)

func upgrade_projectile_size(amount: float) -> void:
	weapon.upgrade_projectile_size(amount)
