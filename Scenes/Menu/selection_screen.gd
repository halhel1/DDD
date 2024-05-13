extends Control

var player_vars
var weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	player_vars = get_node("/root/PlayerManager")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_sniper_pressed():
	player_vars.update_player_weapon("sniper")
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
	pass # Replace with function body.


func _on_machine_gun_pressed():
	player_vars.update_player_weapon("machine_gun")
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
	pass # Replace with function body.


func _on_cannon_pressed():
	weapon=player_vars.update_player_weapon("cannon")
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
	pass # Replace with function body.


func _on_shotgun_pressed():
	player_vars.update_player_weapon("shotgun")
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
	pass # Replace with function body.


func _on_pulse_pressed():
	player_vars.update_player_weapon("pulse")
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
	pass # Replace with function body.


func _on_base_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
	pass # Replace with function body.

