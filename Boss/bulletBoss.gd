extends Area2D


var direction = Vector2.RIGHT
var speed = 0

func _physics_process(delta):
	position += direction * speed * delta
	
	

func _on_screen_exited():
	queue_free()
