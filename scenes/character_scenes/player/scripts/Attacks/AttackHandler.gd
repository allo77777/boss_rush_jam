extends Attack
class_name AttackHandler

#---References
@export var state_machine: Node

#---Variables---
var element

#---Function---
func Update(_delta: float):
	
	#Gets the current element from the player stats
	element = player_stats.element[player_stats.element_index]
	
	if can_attack:
		#Primary attack
		if Input.is_action_pressed("primary_attack"):		
			#Handler -> Primary
			AttackTransition.emit(self, "Primary")		
		
		#Secondary attack
		if Input.is_action_just_pressed("secondary_attack"):		
			#Verifies the current element to determine the attack
			match element:		
					
				"fire":
					#Handler -> Secondary fire
					AttackTransition.emit(self, "SecondaryFire")
	
				"earth":
					#Handler -> Secondary earth
					AttackTransition.emit(self, "SecondaryEarth")
			
				"water":
				#Handler -> Secondary water
					AttackTransition.emit(self, "SecondaryWater")
		
				"air":
					#Handler -> Secondary air
					AttackTransition.emit(self, "SecondaryAir")
		
		
			#Tertiary attack
		if Input.is_action_just_pressed("tertiary_attack"):		
			#Verifies the current element to determine the attack
			match element:		
					
				"fire":
					#Handler -> Tertiary fire
					AttackTransition.emit(self, "TertiaryFire")

				"earth":
					#Handler -> Tertiary earth
					AttackTransition.emit(self, "TertiaryEarth")
				
				"water":
					#Handler -> Tertiary water
					AttackTransition.emit(self, "TertiaryWater")
			
				"air":
					#Handler -> Tertiary air
					AttackTransition.emit(self, "TertiaryAir")
