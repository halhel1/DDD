extends "res://Scenes/Weapons/weapons_base.gd"

@export var max_shots: int = 3
var pulse_count: int = 0

func _ready():
	speed = 900
	scale_vector = Vector2(1,1)
	damage_amount = 200
	spread_radius = 2
	$WeaponCooldown.wait_time = 0.1
	$PulseTimer.wait_time = 0.05


func _process(_delta):
	if (Input.is_action_pressed("attack") && can_fire):
		$WeaponCooldown.start()
		can_fire = false
		fire_pulses()

func fire_pulses():
	if pulse_count < max_shots:
		fire()
		pulse_count += 1
		sfx_shoot.play()
		$PulseTimer.start()

func _on_pulse_timer_timeout():
	$PulseTimer.stop()
	fire_pulses()

func _on_weapon_cooldown_timeout():
	$WeaponCooldown.stop()
	pulse_count = 0
	can_fire = true
