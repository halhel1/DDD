extends Node
var language_set = false
# Called when the node enters the scene tree for the first time.
func _ready():	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_return_pressed():
	get_tree().change_scene_to_file("res://Scenes/options.tscn")
	pass # Replace with function body.

func _on_option_button_item_selected(index):
	if index == 0:
		TranslationServer.set_locale("en")
		language_set = true
	elif index == 1:
		TranslationServer.set_locale("zh")
		language_set = true
	return language_set
	pass # Replace with function body.
