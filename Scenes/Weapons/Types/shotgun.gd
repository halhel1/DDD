class_name Shotgun extends "res://Scenes/Weapons/weapons_base.gd"

func _ready():
	speed = 600
	scale_vector = Vector2(0.5,0.5)
	damage_amount = 2.5
	spread_radius = 20
	$WeaponCooldown.wait_time = 1
	num_bullets = 50

