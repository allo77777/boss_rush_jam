extends State
class_name WallSlideState

#Plays once
func Enter():	
	if player.debug_mode == true:
		print("WallSlide")
		
	animation_tree.animation_mode.travel("WallSlideLanding") #Animation
	
	player.DOUBLE_JUMP_USED = player.DOUBLE_JUMP_AMOUNT #Reset double jump
	player.DASH_USED = player.DASH_AMOUNT #Reset dash
	
	Direction(true) #Function determines which way the player is looking and moving
	
func Exit():
	coyote_time.start()

func Physics_Update(_delta: float):
	#X-Axis movement
	Direction(false)
	
	player.velocity.x = player.SPEED * direction
	
	#Y-Axis movement
	player.velocity.y = player.WALLSLIDE_SPEED
	
	#Determines the side the player slides on
	if raycast_up_right.is_colliding():
		player_sprite.flip_h = true
		player.facing = -1
		
	elif raycast_up_left.is_colliding():
		player_sprite.flip_h = false
		player.facing = 1
	
	#---Exit WallSlide state---
	
	#WallSlide -> Air
	else:
		StateTransition.emit(self, "Air")
		
	#WallSlide -> Dash
	if Input.is_action_just_pressed("dash") and player.DASH:				
		StateTransition.emit(self, "Dash")
		
	elif Input.is_action_just_pressed("crouch"):
		StateTransition.emit(self, "Air")
		
		#Wallslide jump
		player.velocity.x = player.WALLSLIDE_JUMP * player.facing
		
	#WallSlide -> Idle
	elif player.is_on_floor():
		StateTransition.emit(self, "Idle")
		
	#WallSlide -> Jump
	elif Input.is_action_just_pressed("jump"):
		StateTransition.emit(self, "Jump")
		
		#Wallslide jump
		player.velocity.x = player.WALLSLIDE_JUMP * player.facing
		
	#Quick jump
	elif jump_cooldown.time_left > 0:
		StateTransition.emit(self, "Jump")
		
		#Wallslide jump
		player.velocity.x = player.WALLSLIDE_JUMP * player.facing
		
		player.DOUBLE_JUMP_USED = player.DOUBLE_JUMP_AMOUNT #Reset double jump
		jump_cooldown.stop()
		
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "WallSlideLanding":
		animation_tree.animation_mode.travel("WallSlide")
