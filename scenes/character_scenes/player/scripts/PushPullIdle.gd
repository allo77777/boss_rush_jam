extends State
class_name PushPullIdleState

func Enter():	
	if player.debug_mode == true:
		print("PushPull Idle")
		
	animation_tree.animation_mode.travel("PushPullIdle") #Animation
	
	if player.interactable_pos:
		if player.interactable_pos.x - player.position.x > 0:			
			player_sprite.flip_h = false
			
		elif player.interactable_pos.x - player.position.x < 0:			
			player_sprite.flip_h = true	
	
func Exit():
	pass
	#player.is_pushpull = false

func Physics_Update(_delta: float):
	#X-Axis movement
	Direction(false) #Function determines which way the player is looking and moving
	
	player.velocity.x = 0
	
	#---Exit PushPull Idle state---
	
	#PushPull Idle -> Air
	if !player.is_on_floor():
		StateTransition.emit(self, "Air")
	
	#PushPull Idle -> Idle
	if !player.is_pushpull:
		StateTransition.emit(self, "Idle")
	
	#PushPull Idle -> PushPull Run
	elif direction != 0:
		StateTransition.emit(self, "PushPullRun")	
