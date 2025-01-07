extends State
class_name DashState

@onready var animation_player: AnimationPlayer = $"../../animation_player"

#Plays once
func Enter():		
	if player.debug_mode == true:
		print("Dash")
		
	animation_tree.set("parameters/idle/active", true)
	animation_tree.animation_mode.travel("Dash") #Animation
	
	player.is_dashing = true

func Exit():
	player.is_dashing = false

func Physics_Update(delta: float):
	#X-Axis movement
	Direction(true) #Function determines which way the player is looking and moving

	player.velocity.x = player.SPEED * player.facing * player.DASH_SPEED_MULTIPLIER
	
	player.velocity.y = 0
	
	#---Exit dash state---
	
	#  When Dash animation is playing
	
	#Dash -> Jump
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		StateTransition.emit(self, "Jump")
		
	#Dash -> Run
	elif Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):		
		StateTransition.emit(self, "Run")
		
	#Coyote Time
	elif !player.is_on_floor() and coyote_time.time_left > 0 and Input.is_action_just_pressed("jump"):
		StateTransition.emit(self, "Jump")
		
		player.DOUBLE_JUMP_USED = player.DOUBLE_JUMP_AMOUNT #Reset double jump	

func _on_animation_tree_animation_finished(anim_name: StringName):		
	#  When dash animation is done
	if anim_name == "Dash":	
		#Dash -> Crouch Idle
		if Input.is_action_pressed("crouch"):
			StateTransition.emit(self, "Crouch_Idle")
			
		#Dash -> Crouch Run
		elif Input.is_action_pressed("crouch") and Input.is_action_pressed("move_left") or Input.is_action_pressed("crouch") and Input.is_action_pressed("move_right"):
			StateTransition.emit(self, "Crouch_Run")
			
		#Dash -> Run
		elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):			
			StateTransition.emit(self, "Run")
		
		#Dash -> Idle
		elif Input.get_action_strength("move_right") - Input.get_action_strength("move_left") == 0:
			StateTransition.emit(self, "Idle")
