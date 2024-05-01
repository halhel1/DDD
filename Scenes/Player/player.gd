extends CharacterBody2D

@export var max_health: float = 100
var current_health:= max_health 

@export var max_speed: int = 350
@export var acceleration: int = 3500
@export var dodge_time: float = 0.5
@export var dodge_cooldown: float = 3
@export var dodge_speed_multiplier: float = 2
@onready var sfx_shoot = $sfx_shoot
@onready var sfx_take_damage = $sfx_take_damage


var invunerable: bool = false
var is_dead: bool =false
var enemies_in_hitbox:Array =[];
var projectile_scene = preload("res://Scenes/Attacks/AttackSuper.tscn")

func ready():
	$HealthBar.max_value = max_health
	$HealthBar.value = current_health
	$CooldownBar.max_value = dodge_cooldown
	$damageTimer.timeout.connect(_on_damage_timer_timeout)

func _process(_delta):
	$CooldownBar.value = $CooldownTimer.time_left
	$AnimatedSprite2D.play()
	if Input.is_action_just_pressed("attack"):
		fire()
	animate()

#func _input(event):
	#if event.is_action_pressed("ui_cancel"):
		#get_tree().change_scene_to_file("res://Scenes/options.tscn")

func take_damage(amount):
	sfx_take_damage.play()
	current_health -= amount
	$HealthBar.value = current_health
	if current_health<=0:
		die();

func fire():

	var projectile = projectile_scene.instantiate()
	projectile.direction = get_global_mouse_position() - $AnimatedSprite2D.global_position
	projectile.global_position = $AnimatedSprite2D.global_position
	projectile.speed = 700
	get_tree().get_root().add_child(projectile)
	sfx_shoot.play()
	

func die():
	is_dead=true
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func _on_player_hitbox_area_entered(area):
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

func _on_player_hitbox_area_exited(area):
	if area.is_in_group("enemy"):
		enemies_in_hitbox.erase(area)
		$damageTimer.stop()
	
func _on_damage_timer_timeout():
	for enemy in enemies_in_hitbox:
		take_damage(15)


func animate():
	var direction: Vector2
	direction.x = Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft")
	direction.y = Input.get_action_strength("moveDown") - Input.get_action_strength("moveUp")
	match(direction):
		Vector2(0,0):
			$AnimatedSprite2D.animation = "f_idle"
			$AnimatedSprite2D.flip_h = false
		Vector2(0,-1):
			$AnimatedSprite2D.animation = "b_walk"
			$AnimatedSprite2D.flip_h = false
		Vector2(0,1):
			$AnimatedSprite2D.animation = "f_walk"
			$AnimatedSprite2D.flip_h = false
		Vector2(-1,0):
			$AnimatedSprite2D.animation = "fr_walk"
			$AnimatedSprite2D.flip_h = true
		Vector2(-1,-1):
			$AnimatedSprite2D.animation = "br_walk"
			$AnimatedSprite2D.flip_h = true
		Vector2(-1,1):
			$AnimatedSprite2D.animation = "fr_walk"
			$AnimatedSprite2D.flip_h = true
		Vector2(1,0):
			$AnimatedSprite2D.animation = "fr_walk"
			$AnimatedSprite2D.flip_h = false
		Vector2(1,-1):
			$AnimatedSprite2D.animation = "br_walk"
			$AnimatedSprite2D.flip_h = false
		Vector2(1,1):
			$AnimatedSprite2D.animation = "fr_walk"
			$AnimatedSprite2D.flip_h = false
