extends State
class_name WallSlideState

#Plays once
func Enter():	
	if player.debug_mode == true:
		print("WallSlide")
		
	animation_tree.animation_mode.travel("WallSlideLanding") #Animation
	
	player_stats.double_jump_used = player_stats.double_jump_amount #Reset double jump
	
func Exit():
	coyote_time.start()

func Physics_Update(_delta: float):
	#X-Axis movement
	Direction(false) #Function determines which way the player is looking and moving
	
	player.velocity.x = player.SPEED * direction
	
	#Y-Axis movement
	player.velocity.y = player.WALLSLIDE_SPEED
	
	#Determines the side the player slides on
	if raycast_up_right.is_colliding():
		player_sprite.flip_h = false
		
	elif raycast_up_left.is_colliding():
		player_sprite.flip_h = true
	
	#---Exit WallSlide state---
	
	#WallSlide -> Air
	else:
		StateTransition.emit(self, "Air")
		
	#WallSlide -> Idle
	if player.is_on_floor():
		StateTransition.emit(self, "Idle")
		
	#WallSlide -> Jump
	elif Input.is_action_just_pressed("jump"):
		StateTransition.emit(self, "Jump")
		
		#Wallslide jump
		player.velocity.x = player.JUMP_HEIGHT * player.facing * 0.7
		
	#Quick jump
	elif jump_cooldown.time_left > 0:
		StateTransition.emit(self, "Jump")
		
		player_stats.double_jump_used = player_stats.double_jump_amount #Reset double jump
		jump_cooldown.stop()
		
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "WallSlideLanding":
		animation_tree.animation_mode.travel("WallSlide")