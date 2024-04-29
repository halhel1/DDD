class_name Attack extends Area2D

@export var direction: Vector2
@export var speed: float = 400
@export var Scale: Vector2 = Vector2(3,3)

func _process(delta):
	translate(direction.normalized() * speed * delta)

func _on_body_entered(body):
	pass
