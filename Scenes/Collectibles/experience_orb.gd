class_name ExperienceOrb extends Area2D



func _on_area_entered(area):
	if(area.is_in_group("player")):
		area.get_parent().collect_exp(20)
		queue_free()
