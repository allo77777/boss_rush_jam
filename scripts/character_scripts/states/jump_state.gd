extends State
class_name JumpState

#Plays once
func Enter():	
	if player.debug_mode == true:
		print("Jump")
	
func Physics_Update(_delta: float):	
	#Coyote Time control
	coyote_time.stop()
	
	Direction(true) #Function determines which way the player is looking and moving
	
	#Y-Axis movement
	player.velocity.y = player.JUMP_HEIGHT
	
	#---Exit jump state---
	
	#Jump -> Air
	if !player.is_on_floor():
		StateTransition.emit(self, "Air")
