extends State
class_name ClimbState

func Enter():	
	if player.debug_mode == true:
		print("Climb")
					
	player.velocity.x = 0
	player.position.x = player.interactable_pos.x

func Exit():
	player.velocity.x = 100

func Physics_Update(_delta: float):
	direction = Input.get_action_strength("crouch") - Input.get_action_strength("look_up")
	
	if direction != 0:
		animation_tree.animation_mode.travel("Climb") #Animation
		
	else:
		animation_tree.animation_mode.travel("ClimbIdle") #Animation
		
		
	#Y-Axis movement	
	player.velocity.y = direction * player.CLIMB_SPEED
		
	#---Exit Climb State---
		
	#Climb -> Idle
	if !player.is_climbing and player.is_on_floor():
		StateTransition.emit(self, "Idle")
		
	#Climb -> Air
	elif !player.is_climbing:
		StateTransition.emit(self, "Air")
		
	#Climb -> Jump
	elif Input.is_action_just_pressed("jump"):
		StateTransition.emit(self, "Jump")
		
		player.is_climbing = false
