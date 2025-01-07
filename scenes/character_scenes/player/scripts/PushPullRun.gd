extends State
class_name PushPullRunState

func Enter():	
	if player.debug_mode == true:
		print("PushPull Run")
					
func Physics_Update(_delta: float):
	#X-Axis movement
	Direction(false) #Function determines which way the player is looking and moving	
		
	if player.interactable_pos:		
		if player.interactable_pos.x - player.global_position.x > 0:

			player_sprite.flip_h = false
			#Determines what animation to play
			if direction == -1:
				animation_tree.animation_mode.travel("Pull") #Animation
			elif direction == 1:
				animation_tree.animation_mode.travel("Push") #Animation	
			
		elif player.interactable_pos.x - player.global_position.x < 0:
			
			player_sprite.flip_h = true
			#Determines what animation to play
			if direction == -1:
				animation_tree.animation_mode.travel("Push") #Animation
			elif direction == 1:
				animation_tree.animation_mode.travel("Pull") #Animation	
	
	player.velocity.x = player.SPEED * direction * player.PUSHPULL_SPEED_MULTIPLIER
	
	#---Exit PushPull Idle state---
	
	#PushPull Run -> Air
	if !player.is_on_floor():
		StateTransition.emit(self, "Air")
	
	#PushPull Run -> Idle
	if !player.is_pushpull:
		StateTransition.emit(self, "Idle")
	
	#PushPull Run -> PushPull Idle 
	elif direction == 0:
		StateTransition.emit(self, "PushPullIdle")	
