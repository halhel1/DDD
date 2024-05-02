class_name Sniper extends "res://Scenes/Weapons/weapons_base.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 1400
	scale = Vector2(1,1)
	damage_amount = 100
	$WeaponCooldown.wait_time = 1
	pass # Replace with function body.

func fire() -> void:
	
	var projectile = projectile_scene.instantiate()
	projectile.direction = get_global_mouse_position() - global_position 
	projectile.global_position = global_position
	projectile.speed = speed
	projectile.damage_amount = damage_amount
	get_tree().get_root().add_child(projectile)
	sfx_shoot.play()
