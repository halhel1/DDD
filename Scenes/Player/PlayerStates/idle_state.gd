class_name IdleState extends State

@onready var machine: StateMachine = get_parent()
var player: Node

func _ready():
	player = machine.get_parent()
	
func _input(event):
	machine.transition_to("WalkingState",{})

func update(_delta):
	if(player.current_health <= 0):
		machine.transition_to("DeathState",{})
