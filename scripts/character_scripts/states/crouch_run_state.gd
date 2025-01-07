extends State
class_name CrouchRunState

#Plays once
func Enter():	
	if player.debug_mode == true:
		print("Crouch Run")
		
	animation_tree.animation_mode.travel("CrouchRun") #Animation
	
	player.DOUBLE_JUMP_USED = player.DOUBLE_JUMP_AMOUNT #Reset double jump
	player.DASH_USED = player.DASH_AMOUNT #Reset dash
	
func Physics_Update(_delta: float):
	#X-Axis movement
	Direction(true) #Function determines which way the player is looking and moving
	
	player.velocity.x = player.SPEED * direction * player.CROUCH_SPEED_MULTIPLIER
	
	#---Exit Crouch Idle state---
	#Crouch Run -> Air
	if !player.is_on_floor():
		StateTransition.emit(self, "Air")
	
	#Crouch Run -> Run
	elif Input.is_action_just_released("crouch"):
		StateTransition.emit(self, "Run")
	
	#Crouch Run -> Crouch Idle
	elif direction == 0:
		StateTransition.emit(self, "Crouch_Idle")
		
	#Crouch Run -> Dash
	elif Input.is_action_just_pressed("dash") and player.DASH:
		StateTransition.emit(self, "Dash")
		
	elif Input.is_action_just_pressed("jump") and player.is_on_floor():
		StateTransition.emit(self, "Jump")
