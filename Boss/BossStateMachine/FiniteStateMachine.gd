extends Node2D
class_name FiniteStateMachine
 
var current_state: stateBoss
var previous_state: stateBoss
 
func _ready():
	current_state = get_child(0) as stateBoss
	print(current_state)
	previous_state = current_state
	current_state.enter()
 
func change_state(state):
	current_state = find_child(state) as stateBoss
	current_state.enter()
 
	previous_state.exit()
	previous_state = current_state
