class_name WalkingState extends State

var max_speed: int 
var acceleration: int 
var dodging: bool = false
var can_dodge: bool = true
var dodge_time: float 
var dodge_cooldown: float 
var dodge_speed_mult: float

var alter_max_speed: int
var cooldown_timer: Node = null

@onready var machine: StateMachine = get_parent()
var player: Node = null

#this is all pretty clunky but will work on fixing that later
func _ready():
	player = machine.get_parent()
	cooldown_timer = player.get_node("CooldownTimer")
	
	max_speed=player.max_speed
	acceleration=player.acceleration
	dodge_time=player.dodge_time
	dodge_cooldown=player.dodge_cooldown
	dodge_speed_mult = player.dodge_speed_multiplier
	
	alter_max_speed = max_speed
	$DodgeTimer.wait_time = dodge_time
	cooldown_timer.wait_time = dodge_cooldown

func physics_update(delta):
	movement_handler(delta)
	
	if Input.is_action_pressed("attack"):
		attack()
	
	if player.velocity == Vector2.ZERO:
		machine.transition_to("IdleState")
	if player.current_health <= 0:
		machine.transition_to("DeathState")

func movement_handler(delta):
	var direction: Vector2
	
	if (!dodging):
		direction = get_input_direction()
		if direction == Vector2.ZERO:
			apply_friction(acceleration * delta)
		else:
			accelerate(direction * acceleration * delta)
		player.move_and_slide()
		if Input.is_action_just_pressed("dodge")&&can_dodge:
			dodge()
	
	else: #accelerate fast & direction locked while dodge
		player.move_and_slide()

func get_input_direction():
	var direction: Vector2
	direction.x = Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft")
	direction.y = Input.get_action_strength("moveDown") - Input.get_action_strength("moveUp")
	return direction.normalized()

func apply_friction(magnitude):
	##once State machine is correctly implemented, else statement here will be redundant
	if player.velocity.length() > magnitude:
		player.velocity -= player.velocity.normalized() * magnitude
	else:
		player.velocity = Vector2.ZERO

func accelerate(magnitude):
	player.velocity += magnitude
	if player.velocity.length() > max_speed:
		player.velocity = player.velocity.normalized() * max_speed

func dodge():
	dodging = true
	can_dodge = false
	max_speed *= dodge_speed_mult
	player.velocity *= dodge_speed_mult
	$DodgeTimer.start()
	cooldown_timer.start()

func _on_cooldown_timer_timeout():
	can_dodge = true
	cooldown_timer.stop()

func _on_dodge_timer_timeout():
	#reset speed and stop dodge
	max_speed = alter_max_speed
	dodging = false
	$DodgeTimer.stop()

func attack():
	var cursor_pos = get_viewport().get_mouse_position()
	
	pass
