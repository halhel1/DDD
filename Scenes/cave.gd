
extends Area2D
func _on_area_entered(area: Area2D):
	if area.is_in_group("player"):
		if(get_tree().current_scene.scene_file_path.to_int() != 3):
			var next_lvl_num = get_tree().current_scene.scene_file_path.to_int() + 1
			var next_lvl_path = "res://Scenes/Levels/level_" + str(next_lvl_num) + ".tscn"
			print(next_lvl_path)
			get_tree().change_scene_to_file(next_lvl_path)
		else:
			get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
