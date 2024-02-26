extends CharacterBody2D

@export var speed: int = 500
@export var dodge_speed: int = 10
@export var max_dodge_distance: int = 200 
var mouse_position: Vector2 = Vector2.ZERO
var is_dodging: bool = false
var dodge_target: Vector2 = Vector2.ZERO
 

func _ready():
	pass

func _process(delta):
	velocity = Vector2(0, 0)
	mouse_position = get_global_mouse_position()
	
	
	if Input.is_action_pressed("moveUp") and not is_dodging:
		velocity.y = -1
	
	if Input.is_action_pressed("moveDown") and not is_dodging:
		velocity.y = 1
	
	if Input.is_action_pressed("moveLeft") and not is_dodging:
		velocity.x = -1
	
	if Input.is_action_pressed("moveRight") and not is_dodging:
		velocity.x = 1
	
	
	
	velocity = velocity.normalized() * speed
	move_and_slide()

	mouse_position = get_global_mouse_position()
	look_at(mouse_position)

	if Input.is_action_just_pressed("dodge") and not is_dodging:
		is_dodging = true
		dodge_target = mouse_position
		dodge()

	if is_dodging:
		dodge()
		
	
	pass
	
	
func dodge():
	var distance_to_target = position.distance_to(dodge_target)
	

	if distance_to_target > max_dodge_distance:
		var direction = (dodge_target - position).normalized()
		dodge_target = position + direction * max_dodge_distance




	if position.distance_to(dodge_target) > 10:  
		var new_position = position.lerp(dodge_target, dodge_speed * get_process_delta_time())
		position = new_position
	else:
		is_dodging = false

