extends Node
class_name StateMachine

#Variables
@export var initial_state: State #The state the player starts at

var current_state: State
var states: Dictionary = {}

func _ready():
	#Adds every state to a dictionnary
	for child in get_children():
		if child is State:
			
			states[child.name.to_lower()] = child
			
			child.StateTransition.connect(on_child_transition)
		else:
			#If the child isn't a state, sends a warning
			push_warning("Child " + child.name + " is not a State for StateMachine")
	
	if initial_state:
		#Enter the inital state if it's a state
		initial_state.Enter()
		current_state = initial_state
		
#Functions
func _process(delta):
	if current_state:
		current_state.Update(delta)
	
func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)
		
#State transition when it receives a "StateTransition" signal
func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
		
	#Exits the current state
	if current_state:
		current_state.Exit()
		
	#Enter the new state
	new_state.Enter()
	
	#Sets the new state to current
	current_state = new_state
