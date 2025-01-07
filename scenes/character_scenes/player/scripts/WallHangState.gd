extends State
class_name WallHangState

#Plays once
func Enter():
	if player.debug_mode == true:
		print("WallHang")
		
	animation_tree.animation_mode.travel("WallHang") #Animation
		
	player_stats.double_jump_used = player_stats.double_jump_amount #Reset double jump
		
	#Set velociy to 0
	player.velocity.y = 0
		
	var grid = 16
	var position_y: float = player.position.y
		
	#Lock player to grid
	position_y /= grid		
	position_y = round(position_y)		
	position_y *= grid
	position_y -= 6
		
	player.position.y = position_y

func Physics_Update(_delta: float):	
	Direction(false)
	
	#Y-Axis movement
	player.velocity.y = 0
	
	#WallHang-> Jump
	if Input.is_action_just_pressed("jump"):
		StateTransition.emit(self, "Jump")
		
		if direction == player.facing or direction == 0:		
			pass
			
		else:			
			#WallHang jump
			player.velocity.x = player.JUMP_HEIGHT * player.facing * 0.7

	if Input.is_action_pressed("crouch"):
		#WallHang-> WallSlide
		if raycast_up_right.is_colliding() and raycast_down_right.is_colliding() or raycast_up_left.is_colliding() and raycast_down_left.is_colliding():
			StateTransition.emit(self, "WallSlide")
			
		#WallHang-> Air
		else:						
			StateTransition.emit(self, "Air")
			
			player.position.y += 5
