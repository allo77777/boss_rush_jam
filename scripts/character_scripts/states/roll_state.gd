extends State
class_name RollState

#Plays once
func Enter():	
	if player.debug_mode == true:
		print("Roll")
		
	animation_tree.animation_mode.travel("Roll") #Animation
	
	player.is_rolling = true

func Exit():
	player.is_rolling = false

func Physics_Update(delta: float):
	#X-Axis movement
	Direction(true) #Function determines which way the player is looking and moving

	player.velocity.x = player.SPEED * player.facing * player.ROLL_SPEED_MULTIPLIER
	
	#Y-Axis movement	
	player.velocity.y += gravity * delta
	
	#---Exit roll state---
	
	#  When roll animation is playing
	
	#Roll -> Jump
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		StateTransition.emit(self, "Jump")
		
	#Roll -> Run
	elif Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):		
		StateTransition.emit(self, "Run")
		
	#Coyote Time
	elif !player.is_on_floor() and coyote_time.time_left > 0 and Input.is_action_just_pressed("jump"):
		StateTransition.emit(self, "Jump")
		
		player.double_jump_used = player.double_jump_amount #Reset double jump	

func _on_animation_tree_animation_finished(anim_name: StringName):		
	#  When roll animation is done
	if anim_name == "Roll":	
		#Roll -> Crouch Idle
		if Input.is_action_pressed("crouch"):
			StateTransition.emit(self, "Crouch_Idle")
			
		#Roll -> Crouch Run
		elif Input.is_action_pressed("crouch") and Input.is_action_pressed("move_left") or Input.is_action_pressed("crouch") and Input.is_action_pressed("move_right"):
			StateTransition.emit(self, "Crouch_Run")
			
		#Roll -> Run
		elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):			
			StateTransition.emit(self, "Run")
		
		#Roll -> Idle
		elif Input.get_action_strength("move_right") - Input.get_action_strength("move_left") == 0:
			StateTransition.emit(self, "Idle")
