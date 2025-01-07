extends Node
class_name AttackMachine

#Variables
@export var initial_attack: Attack #The attack the player starts at

var current_attack: Attack
var attacks: Dictionary = {}

func _ready():
	#Adds every attack to a dictionnary
	for child in get_children():
		if child is Attack:
			
			attacks[child.name.to_lower()] = child
			
			child.AttackTransition.connect(on_child_transition)
			
		#elif child is 
		else:
			#If the child isn't a attack, sends a warning
			push_warning("Child " + child.name + " is not a Attack for AttackMachine")
	
	if initial_attack:
		#Enter the inital attack if it's a attack
		initial_attack.Enter()
		current_attack = initial_attack
		
#Functions
func _process(delta):
	if current_attack:
		current_attack.Update(delta)
	
func _physics_process(delta):
	if current_attack:
		current_attack.Physics_Update(delta)
		
#Attack transition when it receives a "Transitioned" signal
func on_child_transition(attack, new_attack_name):
	if attack != current_attack:
		return
	
	var new_attack = attacks.get(new_attack_name.to_lower())
	if !new_attack:
		return
		
	#Exits the current attack
	if current_attack:
		current_attack.Exit()
		
	#Enter the new attack
	new_attack.Enter()
	
	#Sets the new attack to current
	current_attack = new_attack
