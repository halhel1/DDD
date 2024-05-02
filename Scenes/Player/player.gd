extends CharacterBody2D

#Able to alter any of these values for upgrades
@export var max_health: float = 100
var current_health:= max_health 

@export var max_speed: int = 350
@export var acceleration: int = 3500
@export var dodge_time: float = 0.5
@export var dodge_cooldown: float = 3
@export var dodge_speed_multiplier: float = 2


@onready var sfx_take_damage: Node = $sfx_take_damage

var invunerable: bool = false
var is_dead: bool =false
var enemies_in_hitbox:Array =[];

func ready():
	$HealthBar.max_value = max_health
	$HealthBar.value = current_health
	$CooldownBar.max_value = dodge_cooldown
	$damageTimer.timeout.connect(_on_damage_timer_timeout)

func _process(_delta) -> void:
	$CooldownBar.value = $CooldownTimer.time_left
	$AnimatedSprite2D.play()

#func _input(event):
	#if event.is_action_pressed("ui_cancel"):
		#get_tree().change_scene_to_file("res://Scenes/options.tscn")

#I am working on making the weapon firing easier to reuse and alter,
#Coming in a future commit
func take_damage(amount) -> void:
	sfx_take_damage.play()
	current_health -= amount
	$HealthBar.value = current_health
	if current_health<=0:
		die();

func die() -> void:
	is_dead=true
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func _on_player_hitbox_area_entered(area) -> void:
	if area.is_in_group("seashell"):
		print("shell collected")
	if area.is_in_group("heart"):
		if current_health!=max_health:
			current_health += 20 
			$HealthBar.value = current_health
	if area.is_in_group("enemy"):
		enemies_in_hitbox.append(area)
		take_damage(15)
		$damageTimer.start();
		$HealthBar.value = current_health

func _on_player_hitbox_area_exited(area) -> void:
	if area.is_in_group("enemy"):
		enemies_in_hitbox.erase(area)
		$damageTimer.stop()
	
func _on_damage_timer_timeout() -> void:
	for enemy in enemies_in_hitbox:
		take_damage(15)
