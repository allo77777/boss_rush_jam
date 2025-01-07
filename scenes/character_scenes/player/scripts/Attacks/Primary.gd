extends Attack
class_name Primary

#---References---
@export var primaryReset: Timer

#---Variable---
var combo = 1

func Enter(): #Plays once
	if player.debug_mode == true:
			print("Primary")
			
	can_attack = false #Is attacking
	
	#Makes the primary animation change depending on the combo amount
	match(combo):
		1:
			attack_animation_tree.attack_mode.travel("Primary1")
			
			primaryReset.stop()
			primaryReset.start()
			
			combo += 1
		2:
			attack_animation_tree.attack_mode.travel("Primary2")
			
			primaryReset.stop()
			primaryReset.start()
			
			combo += 1
		3:
			attack_animation_tree.attack_mode.travel("Primary3")
			
			primaryReset.stop()
			primaryReset.start()
			
			combo = 1
			
func Exit():
	#Is no longer attacking when leaving
	can_attack = true
	
func _on_attack_animation_tree_animation_finished(anim_name: StringName) -> void:
	#When the animation is done, return to the handler
	AttackTransition.emit(self, "AttackHandler")	
	
func _on_primary_reset_timeout() -> void:
	#After 0.5 sec sets the combo back to 1 
	combo = 1
