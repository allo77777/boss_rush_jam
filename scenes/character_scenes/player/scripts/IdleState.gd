extends State
class_name IdleState

#Plays once
func Enter():
	#if player.debug_mode == true:
		#print("Idle")
		
	animation_tree.animation_mode.travel("Idle") #Animation
	
	player_stats.double_jump_used = player_stats.double_jump_amount #Reset double jump
	
	look_to_mouse = true #Player is able to look towards mouse position

func Exit():
	look_to_mouse = false #Player isn't able to look towards mouse position

func Physics_Update(_delta: float):			
	Direction(true) #Function determines which way the player is looking and moving
	
	player.velocity.x = 0 #No movement for idle state
	
	#---Exit idle state---
	
	#Idle -> Jump
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		StateTransition.emit(self, "Jump")
		
	#Idle -> Roll
	elif Input.is_action_just_pressed("roll") and player.is_on_floor():
		StateTransition.emit(self, "Roll")
	
	#Idle -> Air
	elif !player.is_on_floor():
		StateTransition.emit(self, "Air")
		
	#Idle -> PushPull Idle
	elif player.is_pushpull:
		StateTransition.emit(self, "PushPullIdle")
		
	#Idle -> Climb
	elif player.is_climbing:
		StateTransition.emit(self, "Climb")
		
	#Idle -> Crouch Idle
	elif Input.is_action_pressed("crouch"):
		StateTransition.emit(self, "CrouchIdle")	
		
	#Idle -> Run
	elif direction != 0:
		StateTransition.emit(self, "Run")		
