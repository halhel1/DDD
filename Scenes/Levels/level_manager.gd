extends Node

class_name levelManager


static var instance = null

var currentLevel : int = 1

var currentLoop : int = 1

func _ready():
	instance = self

func get_current_level() -> int:
	return currentLevel

func increase_level() -> void:
	currentLevel += 1

func set_current_level(level : int) -> void:
	currentLevel = max(1, level)

func increase_loop() -> void:
	currentLoop += 1

func get_current_loop() -> int:
	return currentLoop

func set_current_loop(loop : int) -> void:
	currentLoop = max(1, loop)
