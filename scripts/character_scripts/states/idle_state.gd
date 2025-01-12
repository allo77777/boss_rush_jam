extends State
class_name IdleState

#Plays once
func Enter():
	if player.debug_mode == true:
		print("Idle")
		
	animation_tree.animation_mode.travel("Idle") #Animation
	
	player.DOUBLE_JUMP_USED = player.DOUBLE_JUMP_AMOUNT #Reset double jump
	player.DASH_USED = player.DASH_AMOUNT #Reset dash

func Physics_Update(_delta: float):			
	Direction(true) #Function determines which way the player is looking and moving
	
	player.velocity.x = 0 #No movement for idle state
	
	#Attack Animation
	if Input.is_action_just_pressed("primary_attack"):
		animation_tree.set("parameters/Idle/Attack/request", 1)
	
	#---Exit idle state---
	
	#Idle -> Jump
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		StateTransition.emit(self, "Jump")
		
	#Idle -> Dash
	elif Input.is_action_just_pressed("dash") and player.DASH:
		StateTransition.emit(self, "Dash")
	
	#Idle -> Air
	elif !player.is_on_floor():
		StateTransition.emit(self, "Air")	
		
	#Idle -> Crouch Idle
	elif Input.is_action_pressed("crouch"):
		StateTransition.emit(self, "Crouch_Idle")	
		
	#Idle -> Run
	elif direction != 0:
		StateTransition.emit(self, "Run")		
