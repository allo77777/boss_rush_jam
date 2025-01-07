extends State
class_name AirState

#Plays once
func Enter():
	if player.debug_mode == true:
		print("Air")
		
	look_to_mouse = true #Player is able to look towards mouse position

func Exit():
	look_to_mouse = false #Player isn't able to look towards mouse position
		
func Physics_Update(delta: float):			
	 #Animations
	if !player.is_on_floor():
		
		if abs(player.velocity.y) < 40:
			animation_tree.animation_mode.travel("JumpMax")
			
		elif player.velocity.y < 0:
			animation_tree.animation_mode.travel("JumpUp")
			
		elif player.velocity.y > 0:
			animation_tree.animation_mode.travel("JumpDown")
		
	#X-Axis movement
	Direction(true) #Function determines which way the player is looking and moving
	
	player.velocity.x = player.SPEED * direction 
	
	#Y-Axis movement	
	player.velocity.y += gravity * delta
	player.velocity.y = lerp(player.prevVelocity.y, player.velocity.y, 0.8)
	
	#Air hang
	if abs(player.velocity.y) < 40:
		gravity *= 0.95
	else:
		gravity = ProjectSettings.get_setting("physics/2d/default_gravity", 980)
	
	#Air resistance
	if !player.is_on_floor():
		player.velocity.x = lerp(player.prevVelocity.x, player.velocity.x, 0.1)
	
	#Variable jump height
	if Input.is_action_just_released("jump") and player.velocity.y < 0:
		player.velocity.y *= 0.4
		
	#---Exit air state---	
	
	#Quick jump
	if player.is_on_floor() and jump_cooldown.time_left > 0:
		StateTransition.emit(self, "Jump")
		
		player.DOUBLE_JUMP_USED = player.DOUBLE_JUMP_AMOUNT #Reset double jump
		jump_cooldown.stop()
		
	#Coyote Time
	elif !player.is_on_floor() and coyote_time.time_left > 0 and Input.is_action_just_pressed("jump"):
		StateTransition.emit(self, "Jump")
		
		player.DOUBLE_JUMP_USED = player.DOUBLE_JUMP_AMOUNT #Reset double jump	
		
	#Air -> Dash
	elif Input.is_action_just_pressed("dash") and player.DASH and player.DASH_USED >= 1 :	
		StateTransition.emit(self, "Dash")
		
		player.DASH_USED -= 1
		
	#Double jump
	elif player.DOUBLE_JUMP == true and player.DOUBLE_JUMP_USED >= 1 and Input.is_action_just_pressed("jump"):
		StateTransition.emit(self, "Jump")
		
		player.DOUBLE_JUMP_USED -= 1
		player.DASH_USED = player.DASH_AMOUNT #Reset dash
		animation_tree.animation_mode.travel("DoubleJump")
		
	#Air -> Idle
	elif player.is_on_floor():
		StateTransition.emit(self, "Idle")
	
	
	elif !player.is_on_floor() and player.velocity.y > 0:					
		#Air -> WallSlide
		if raycast_up_right.is_colliding() and raycast_down_right.is_colliding() or raycast_up_left.is_colliding() and raycast_down_left.is_colliding():
			StateTransition.emit(self, "Wall_Slide")
