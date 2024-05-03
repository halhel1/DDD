class_name MachineGun extends "res://Scenes/Weapons/weapons_base.gd"


func _ready():
	speed = 600
	scale_vector = Vector2(1.1,1.1)
	spread_radius = 15
	damage_amount = 20
	$WeaponCooldown.wait_time = 0.2

func _process(_delta):
	if(Input.is_action_pressed("attack")&&can_fire):
		fire()
		can_fire = false
		sfx_shoot.play()
		$WeaponCooldown.start()
