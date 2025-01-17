extends Node

@export var initial_state: BossState


var current_state: BossState
var states:Dictionary = {}

func _ready():
	for child in get_children():
		if child is BossState: #is is like == but checks if it extends to said class
			states[child.name.to_lower()] = child
			child.BossTransition.connect(on_child_transition)
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(_delta):
	if current_state:
		current_state.update(_delta)
	
	
	
func _physics_process(_delta):
	if current_state:
		current_state.physics_update(_delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())

	if !new_state:
		return

	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
