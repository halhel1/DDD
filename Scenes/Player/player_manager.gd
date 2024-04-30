extends Node

var player_instance

func _ready():
	var player_scene = load("res://Scenes/Player/player.tscn")
	player_instance = player_scene.instantiate()
	add_child(player_instance)
func get_player_instance():
	return player_instance
