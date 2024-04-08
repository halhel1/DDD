# Virtual base state class
class_name State extends Node

var state_machine = null

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func enter(_msg : Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass

