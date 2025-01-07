extends State
class_name WallClimbState

#Plays once
func Enter():
	if player.debug_mode == true:
		print("WallCLimb")
		
		animation_tree.animation_mode.travel("WallClimb") #Animation
		
func Exit():
	player.position.x += 10

func Physics_Update(_delta: float):	
	#Y-Axis movement
	player.velocity.y = 0

#---Exit WallClimb State--

#WallClimb -> Idle
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "WallClimb":
		StateTransition.emit(self, "Idle")
		
		player.position.y -= 40
