extends stateBoss

class_name DashBoss
 
@onready var timer = $DashTimer
 
func transition():
	if ray_cast.is_colliding():
		get_parent().change_state("ShootBoss")
 
func dash():
	var tween = get_tree().create_tween()
	tween.tween_property(owner, "position", player.position, 0.75)
 
func _on_timer_timeout():
	dash()
 
func enter():
	super.enter()
	timer.start()
 
func exit():
	super.exit()
	timer.stop()
