class_name Shotgun extends "res://Scenes/Weapons/weapons_base.gd"

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 600
	scale = Vector2(1,1)
	damage_amount = 5
	$WeaponCooldown.wait_time = cooldown
	pass # Replace with function body.

func fire() -> void:
	for x in 20:
		var projectile = projectile_scene.instantiate()
		projectile.direction = get_global_mouse_position() - global_position 
		projectile.direction += Vector2(rng.randf_range(-80,80),rng.randf_range(-80,80))
		projectile.global_position = global_position
		projectile.speed = speed
		projectile.damage_amount = damage_amount
		get_tree().get_root().add_child(projectile)
	sfx_shoot.play()
