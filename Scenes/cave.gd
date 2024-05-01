extends Area2D
func _on_area_entered(area: Area2D):
	if area.is_in_group("player"):
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_lvl_num = current_scene_file.to_int() + 1
		var next_lvl_path = "res://Scenes/Levels/level_" + str(next_lvl_num) + ".tscn"
		get_tree().change_scene_to_file(next_lvl_path)
