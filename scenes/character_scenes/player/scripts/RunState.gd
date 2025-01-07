extends State
class_name RunState

#Plays once
func Enter():
	if player.debug_mode == true:
		print("Run")
		
	animation_tree.animation_mode.travel("Run") #Animation
	
	player_stats.double_jump_used = player_stats.double_jump_amount #Reset double jump

func Physics_Update(_delta: float):
	#X-Axis movement
	Direction(true) #Function determines which way the player is looking and moving
	
	player.velocity.x = player.SPEED * direction
	
	#---Exit run state---
	
	#Run -> Jump
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		StateTransition.emit(self, "Jump")
		
	#Run -> Roll
	elif Input.is_action_just_pressed("roll") and player.is_on_floor():
		StateTransition.emit(self, "Roll")
		
	#Run -> Air
	elif !player.is_on_floor():
		StateTransition.emit(self, "Air")
	
	#Run -> PushPull Run
	elif player.is_pushpull:
		StateTransition.emit(self, "PushPullRun")
	
	#Run -> Crouch Run
	elif Input.is_action_just_pressed("crouch"):
		StateTransition.emit(self, "CrouchRun")
		
	#Run -> Idle
	elif direction == 0:
		StateTransition.emit(self, "Idle")
