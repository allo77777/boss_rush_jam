extends State
class_name CrouchIdleState

#Plays once
func Enter():	
	if player.debug_mode == true:
		print("Crouch Idle")
		
	animation_tree.animation_mode.travel("CrouchIdle") #Animation
	
	player.DOUBLE_JUMP_USED = player.DOUBLE_JUMP_AMOUNT #Reset double jump
	player.DASH_USED = player.DASH_AMOUNT #Reset dash
	
	look_to_mouse = true #Player is able to look towards mouse position

func Exit():
	look_to_mouse = false #Player isn't able to look towards mouse position

func Physics_Update(_delta: float):
	#X-Axis movement
	Direction(true) #Function determines which way the player is looking and moving

	player.velocity.x = 0 #No movement for idle state
	
	#---Exit Crouch Idle state---
	#Crouch Idle -> Air
	if !player.is_on_floor():
		StateTransition.emit(self, "Air")
	
	#Crouch Idle -> Idle
	elif Input.is_action_just_released("crouch"):
		StateTransition.emit(self, "Idle")
		
	#Crouch Idle -> Crouch Run
	elif direction != 0:
		StateTransition.emit(self, "Crouch_Run")
	
	#Crouch Idle -> Dash	
	elif Input.is_action_just_pressed("dash") and player.DASH:
		StateTransition.emit(self, "Dash")
		
	elif Input.is_action_just_pressed("jump") and player.is_on_floor():
		StateTransition.emit(self, "Jump")
