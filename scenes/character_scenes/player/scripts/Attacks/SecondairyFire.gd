extends Attack
class_name SecondaryFire
 
func Enter():
	if player.debug_mode == true:
				print("Secondary Fire")
				
	attack_animation_tree.attack_mode.travel("SecondaryFire")

func Update(delta):
	if Input.is_action_just_released("secondary_attack"):
		#Secondary Fire -> attack handler
		AttackTransition.emit(self, "AttackHandle")
