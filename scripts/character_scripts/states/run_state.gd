extends State
class_name RunState

#Plays once
func Enter():
	if player.debug_mode == true:
		print("Run")
		
	animation_tree.animation_mode.travel("Run") #Animation
	
	player.DOUBLE_JUMP_USED = player.DOUBLE_JUMP_AMOUNT #Reset double jump
	player.DASH_USED = player.DASH_AMOUNT #Reset dash

func Physics_Update(_delta: float):
	#X-Axis movement
	Direction(true) #Function determines which way the player is looking and moving
	
	player.velocity.x = player.SPEED * direction
	
	#Attack Animation
	if Input.is_action_just_pressed("primary_attack"):
		animation_tree.set("parameters/Run/Attack/request", 1)
	
	#---Exit run state---
	
	#Run -> Jump
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		StateTransition.emit(self, "Jump")
		
	#Run -> Dash
	elif Input.is_action_just_pressed("dash") and player.DASH:
		StateTransition.emit(self, "Dash")
		
	#Run -> Air
	elif !player.is_on_floor():
		StateTransition.emit(self, "Air")
	
	#Run -> Crouch Run
	elif Input.is_action_just_pressed("crouch"):
		StateTransition.emit(self, "Crouch_Run")
		
	#Run -> Idle
	elif direction == 0:
		StateTransition.emit(self, "Idle")
