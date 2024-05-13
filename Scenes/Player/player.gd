class_name Player extends CharacterBody2D

#Able to alter any of these values for upgrades
@export var max_health: float = 100
var current_health:= max_health 

@export var max_speed: int = 350
@export var acceleration: int = 3500
@export var dodge_time: float = 0.5
@export var dodge_cooldown: float = 1.5
@export var dodge_speed_multiplier: float = 2

@export var exp_per_level = 100
var experience: float = 0
var player_level: int = 1
var weapon: String

@onready var damage_numbers_origin: Node2D = $DamageNumbersOrigin
var player_vars: Node

@onready var sfx_take_damage: Node = $sfx_take_damage

var invunerable: bool = false
var is_dead: bool =false
var enemies_in_hitbox: Array = [];

var weapon_type: Dictionary = {
	sniper = "res://Scenes/Weapons/Types/sniper.tscn",
	machine_gun = "res://Scenes/Weapons/Types/machine_gun.tscn",
	cannon = "res://Scenes/Weapons/Types/cannon.tscn",
	shotgun = "res://Scenes/Weapons/Types/shotgun.tscn",
	pulse = "res://Scenes/Weapons/Types/pulse.tscn",
	weapon_base = "res://Scenes/Weapons/weapon_base.tscn"
}

func _ready():
	player_vars = get_node("/root/PlayerManager")
	current_health = player_vars.get_player_health()
	experience= player_vars.get_player_experience()
	weapon=player_vars.get_player_weapon()
	set_bars()
	set_cooldown()
	$damageTimer.timeout.connect(_on_damage_timer_timeout)
	change_weapon(weapon)

func _process(_delta) -> void:
	$PlayerBars/CooldownBar.value = $CooldownTimer.time_left
	$AnimatedSprite2D.play()

func take_damage(amount: float) -> void:
	player_vars.update_player_health(player_vars.get_player_health()-amount)
	current_health = player_vars.get_player_health()
	sfx_take_damage.play()
	$PlayerBars/HealthBar.value = current_health
	if current_health<=0:
		die()

func collect_exp(amount: float) -> void:
	player_vars.update_player_experience(player_vars.get_player_experience()+amount)
	experience=player_vars.get_player_experience()
	if (experience >= exp_per_level):
		player_level += 1
		experience = 0
		upgrade()
	$PlayerBars/ExperienceBar.value = experience

func upgrade() -> void:
	#upgrade logic will go in here, but will deal with that tomorrow
	pass

func die() -> void:
	is_dead=true
	player_vars.update_player_health(max_health)
	current_health = max_health
	$PlayerBars/HealthBar.value = current_health
	player_vars.update_player_experience(0)
	experience=0
	get_tree().change_scene_to_file("res://Scenes/Menu/game_over.tscn")

func _on_player_hitbox_area_entered(area) -> void:
	if area.is_in_group("seashell"):
		print("shell collected")
	if area.is_in_group("experience_orb"):
		collect_exp(5)
	if area.is_in_group("heart"):
		if current_health!=max_health:
			current_health += 20 
			player_vars.player_health+=20
			$PlayerBars/HealthBar.value = current_health
	if area.is_in_group("enemy"):
		enemies_in_hitbox.append(area)
		take_damage(15)
		DamageNumbers.display_number(15, damage_numbers_origin.global_position)
		$damageTimer.start();
		$PlayerBars/HealthBar.value = current_health

func _on_player_hitbox_area_exited(area) -> void:
	if area.is_in_group("enemy"):
		enemies_in_hitbox.erase(area)
		$damageTimer.stop()

func _on_damage_timer_timeout() -> void:
	for enemy in enemies_in_hitbox:
		take_damage(15)

func set_bars() -> void:
	$PlayerBars/CooldownBar.max_value = dodge_cooldown
	$PlayerBars/HealthBar.max_value = max_health
	$PlayerBars/HealthBar.value = current_health
	$PlayerBars/ExperienceBar.value = experience
	$PlayerBars/ExperienceBar.max_value = exp_per_level

func set_cooldown() -> void:
	$CooldownTimer.wait_time = dodge_cooldown

#String weapon is name of var in weapon_types dict
func change_weapon(weapon: String) -> void:
	if $Hand/Sprite2D.get_child_count() != 0:
		$Hand/Sprite2D.get_child(0).queue_free()  
	var new_weapon_instance = load(weapon_type[weapon]).instantiate() 
	$Hand/Sprite2D.add_child(new_weapon_instance)
