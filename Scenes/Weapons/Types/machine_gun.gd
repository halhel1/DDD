class_name MachineGun extends "res://Scenes/Weapons/weapons_base.gd"

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 800
	scale = Vector2(0.5,0.5)
	damage_amount = 3
	$WeaponCooldown.wait_time = 0.2
	pass # Replace with function body.
	
func _process(_delta):
	if(Input.is_action_pressed("attack")):
		fire()
		can_fire = false

func fire() -> void:
	var projectile = projectile_scene.instantiate()
	projectile.direction = get_global_mouse_position() - global_position 
	projectile.direction += Vector2(rng.randf_range(-40,40),rng.randf_range(-40,40))
	projectile.global_position = global_position
	projectile.speed = speed
	projectile.scale = scale
	projectile.damage_amount = damage_amount
	get_tree().get_root().add_child(projectile)

	sfx_shoot.play()
